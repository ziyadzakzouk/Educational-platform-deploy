document.addEventListener('DOMContentLoaded', function () {
    const darkModeToggle = document.getElementById('dark-mode-toggle');
    const darkModeCss = document.getElementById('dark-mode-css');

    // Check if dark mode is enabled in local storage
    if (localStorage.getItem('darkMode') === 'enabled') {
        enableDarkMode();
        darkModeToggle.checked = true;
    }

    darkModeToggle.addEventListener('change', function () {
        if (darkModeToggle.checked) {
            enableDarkMode();
        } else {
            disableDarkMode();
        }
    });

    function enableDarkMode() {
        document.body.classList.add('dark-theme');
        darkModeCss.disabled = false;
        localStorage.setItem('darkMode', 'enabled');
    }

    function disableDarkMode() {
        document.body.classList.remove('dark-theme');
        darkModeCss.disabled = true;
        localStorage.setItem('darkMode', 'disabled');
    }
});
