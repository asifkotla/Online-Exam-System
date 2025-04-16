
    function showValidationAlert() {
        var summary = document.getElementById('<%= ValidationSummary2.ClientID %>');
    var alertBox = document.getElementById('validationAlert');
        if (summary && summary.innerHTML.trim().length > 0) {
        alertBox.style.display = "block";
        } else {
        alertBox.style.display = "none";
        }
    }

    // Attach to Page Load and also on any button click
    window.onload = showValidationAlert;

    document.addEventListener('DOMContentLoaded', function () {
        var form = document.forms[0];
    if (form) {
        form.onsubmit = function () {
            setTimeout(showValidationAlert, 10);
        };
        }
    });

