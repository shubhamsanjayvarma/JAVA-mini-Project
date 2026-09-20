/**
 * Online Course Management System (OCMS)
 * Minimal Client-Side JavaScript
 */

function confirmAction(message) {
    return confirm(message || "Are you sure you wish to proceed with this action?");
}

document.addEventListener("DOMContentLoaded", function() {
    // Auto-dismiss or wire simple confirm dialogs on delete buttons
    var deleteForms = document.querySelectorAll("form.confirm-delete");
    deleteForms.forEach(function(form) {
        form.addEventListener("submit", function(e) {
            if (!confirmAction("Are you sure you want to delete this item? This action cannot be undone.")) {
                e.preventDefault();
            }
        });
    });
});
