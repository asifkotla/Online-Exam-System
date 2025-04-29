
    // Auto-submit if tab is switched or minimized
    document.addEventListener('visibilitychange', function () {
        if (document.hidden) {
        __doPostBack('AutoSubmit', '');
        }
    });

    // Auto-submit if back/forward button is used
    history.pushState(null, null, location.href);
    window.onpopstate = function () {
        __doPostBack('AutoSubmit', '');
    };

    // Disable right-click
    document.addEventListener('contextmenu', function (e) {
        e.preventDefault();
    alert("Right-click is disabled during the exam.");
    });

    // Warn before refresh/close
    window.onbeforeunload = function () {
        __doPostBack('AutoSubmit', '');
    return "Your exam will be submitted if you leave or refresh.";
    };

    // Optional: Disable keyboard shortcuts (like Alt+Tab, Ctrl+R, etc.)
    document.addEventListener('keydown', function (e) {
        if ((e.altKey && e.key === 'Tab') || e.key === 'F5' || (e.ctrlKey && e.key === 'r')) {
        e.preventDefault();
    alert("Keyboard shortcuts are disabled during the exam.");
        }
    });

    // Fullscreen on load
    function fullScreen() {
        if (document.documentElement.requestFullscreen) {
        document.documentElement.requestFullscreen();
        }
    }
    window.onload = fullScreen;
