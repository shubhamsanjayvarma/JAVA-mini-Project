package com.ocms.util;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.security.spec.InvalidKeySpecException;
import java.security.spec.KeySpec;
import java.util.HexFormat;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.PBEKeySpec;

/**
 * Standard Java-supported Password Hashing Utility.
 * Uses PBKDF2WithHmacSHA256 with cryptographically secure random salt.
 * Fully self-contained within standard JDK; no third-party frameworks required.
 */
public class PasswordUtil {

    private static final Logger LOGGER = Logger.getLogger(PasswordUtil.class.getName());
    private static final String ALGORITHM = "PBKDF2WithHmacSHA256";
    private static final int ITERATIONS = 65536;
    private static final int KEY_LENGTH = 256;
    private static final int SALT_LENGTH = 16;

    private PasswordUtil() {
    }

    /**
     * Hashes a plaintext password using PBKDF2WithHmacSHA256 with a random 16-byte salt.
     * Output format: saltHex:hashHex
     *
     * @param password plaintext password
     * @return salt:hash string
     */
    public static String hashPassword(String password) {
        if (password == null || password.trim().isEmpty()) {
            throw new IllegalArgumentException("Password cannot be null or empty.");
        }

        try {
            byte[] salt = new byte[SALT_LENGTH];
            SecureRandom random = new SecureRandom();
            random.nextBytes(salt);

            byte[] hash = pbkdf2(password.toCharArray(), salt, ITERATIONS, KEY_LENGTH);
            HexFormat hex = HexFormat.of();
            return hex.formatHex(salt) + ":" + hex.formatHex(hash);
        } catch (NoSuchAlgorithmException | InvalidKeySpecException e) {
            LOGGER.log(Level.SEVERE, "Failed to compute password hash", e);
            throw new RuntimeException("Cryptographic error while hashing password", e);
        }
    }

    /**
     * Verifies a candidate password against a stored salt:hash string.
     * Uses constant-time comparison (MessageDigest.isEqual) to prevent timing attacks.
     *
     * @param candidatePassword plaintext candidate password
     * @param storedHash        salt:hash formatted string
     * @return true if password matches, false otherwise
     */
    public static boolean verifyPassword(String candidatePassword, String storedHash) {
        if (candidatePassword == null || storedHash == null || !storedHash.contains(":")) {
            return false;
        }

        String[] parts = storedHash.split(":", 2);
        if (parts.length != 2) {
            return false;
        }

        try {
            HexFormat hex = HexFormat.of();
            byte[] salt = hex.parseHex(parts[0]);
            byte[] expectedHash = hex.parseHex(parts[1]);

            byte[] candidateHash = pbkdf2(candidatePassword.toCharArray(), salt, ITERATIONS, KEY_LENGTH);
            return MessageDigest.isEqual(expectedHash, candidateHash);
        } catch (Exception e) {
            LOGGER.log(Level.WARNING, "Error during password verification", e);
            return false;
        }
    }

    private static byte[] pbkdf2(char[] password, byte[] salt, int iterations, int keyLength)
            throws NoSuchAlgorithmException, InvalidKeySpecException {
        KeySpec spec = new PBEKeySpec(password, salt, iterations, keyLength);
        SecretKeyFactory factory = SecretKeyFactory.getInstance(ALGORITHM);
        return factory.generateSecret(spec).getEncoded();
    }
}
