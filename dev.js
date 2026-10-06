const { spawn, execSync, exec } = require('child_process');
const fs = require('fs');
const path = require('path');
const http = require('http');

console.log('\n===============================================================');
console.log('   Online Course Management System (OCMS)');
console.log('   Local Development Server (Apache Tomcat 10.1 + MySQL)');
console.log('===============================================================\n');

// 1. Locate Apache Tomcat installation
let catalinaHome = process.env.CATALINA_HOME;
const defaultPath = 'C:\\Users\\sv369\\tools\\apache-tomcat-10.1.60';

if (!catalinaHome || !fs.existsSync(catalinaHome)) {
    if (fs.existsSync(defaultPath)) {
        catalinaHome = defaultPath;
    } else {
        console.error('[ERROR] Apache Tomcat 10.1 directory not found!');
        console.error('Please ensure the CATALINA_HOME environment variable is configured.');
        process.exit(1);
    }
}

const isWindows = process.platform === 'win32';
const catalinaCmd = path.join(catalinaHome, 'bin', isWindows ? 'catalina.bat' : 'catalina.sh');
const webappsDir = path.join(catalinaHome, 'webapps');

console.log(`[Config] Using Tomcat at: ${catalinaHome}`);

// 2. Build the WAR package using Maven
console.log('\n[1/4] Building latest WAR package (mvn package -DskipTests)...');
try {
    execSync('mvn package -DskipTests', { stdio: 'inherit' });
} catch (err) {
    console.error('\n[ERROR] Maven compilation/packaging failed.');
    process.exit(1);
}

// 3. Deploy ocms.war to Tomcat webapps
const warSource = path.join(__dirname, 'target', 'ocms.war');
const warDest = path.join(webappsDir, 'ocms.war');

if (!fs.existsSync(warSource)) {
    console.error(`\n[ERROR] Build artifact not found at: ${warSource}`);
    process.exit(1);
}

console.log(`\n[2/4] Deploying ocms.war to ${webappsDir}...`);
try {
    fs.copyFileSync(warSource, warDest);
    console.log('  -> ocms.war copied to Tomcat webapps successfully!');
} catch (err) {
    console.error('[ERROR] Failed to copy ocms.war to webapps:', err.message);
    process.exit(1);
}

// 4. Browser opener helper
function openBrowser(url) {
    console.log(`\n[4/4] Opening application in default browser: ${url}\n`);
    const cmd = isWindows
        ? `start "" "${url}"`
        : process.platform === 'darwin'
        ? `open "${url}"`
        : `xdg-open "${url}"`;
    exec(cmd, () => {});
}

// 5. Port checker
function checkPort(port, callback) {
    const req = http.get(`http://localhost:${port}/`, () => {
        callback(true);
    });
    req.on('error', () => {
        callback(false);
    });
    req.setTimeout(1200, () => {
        req.destroy();
        callback(false);
    });
}

console.log('\n[3/4] Checking Tomcat server status on port 8080...');
checkPort(8080, (isRunning) => {
    const appUrl = 'http://localhost:8080/ocms/';

    if (isRunning) {
        console.log('  -> Tomcat is already running on port 8080.');
        console.log('  -> Tomcat will auto-reload the newly deployed ocms.war.');
        openBrowser(appUrl);
        console.log('Server is running. Press Ctrl+C in this terminal when finished.');
    } else {
        console.log('  -> Starting Tomcat 10.1 in foreground...');
        
        const tomcatProcess = spawn(catalinaCmd, ['run'], {
            cwd: catalinaHome,
            env: { ...process.env, CATALINA_HOME: catalinaHome },
            shell: true
        });

        let browserOpened = false;

        const checkAppReady = () => {
            if (browserOpened) return;
            const testReq = http.get(appUrl, (res) => {
                if (!browserOpened) {
                    browserOpened = true;
                    clearInterval(pollTimer);
                    openBrowser(appUrl);
                }
            });
            testReq.on('error', () => {});
        };

        const pollTimer = setInterval(checkAppReady, 1000);

        tomcatProcess.stdout.on('data', (data) => {
            const output = data.toString();
            process.stdout.write(output);
            if (output.includes('Server startup in') || (output.includes('Deployment of web application archive') && output.includes('ocms.war'))) {
                setTimeout(checkAppReady, 600);
            }
        });

        tomcatProcess.stderr.on('data', (data) => {
            process.stderr.write(data.toString());
        });

        const stopServer = () => {
            clearInterval(pollTimer);
            console.log('\nStopping Tomcat server...');
            try {
                if (isWindows && tomcatProcess.pid) {
                    execSync(`taskkill /pid ${tomcatProcess.pid} /T /F`, { stdio: 'ignore' });
                } else {
                    tomcatProcess.kill('SIGINT');
                }
            } catch (e) {
                // Ignore kill errors on exit
            }
            process.exit(0);
        };

        process.on('SIGINT', stopServer);
        process.on('SIGTERM', stopServer);

        tomcatProcess.on('exit', (code) => {
            clearInterval(pollTimer);
            console.log(`\nTomcat server stopped (exit code: ${code}).`);
            process.exit(code || 0);
        });
    }
});
