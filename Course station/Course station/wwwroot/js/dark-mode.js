document.addEventListener("DOMContentLoaded", function () {
    const toggleButton = document.getElementById("dark-mode-toggle");
    const darkModeCss = document.getElementById("dark-mode-css");

    // Check the user's preference from localStorage
    if (localStorage.getItem("darkMode") === "enabled") {
        enableDarkMode();
    } else {
        disableDarkMode();
    }

    toggleButton.addEventListener("click", function () {
        if (localStorage.getItem("darkMode") === "enabled") {
            disableDarkMode();
        } else {
            enableDarkMode();
        }
    });

    function enableDarkMode() {
        document.body.classList.add("dark-mode");
        document.querySelector("nav").classList.add("dark-mode");
        darkModeCss.removeAttribute("disabled");
        localStorage.setItem("darkMode", "enabled");
        toggleButton.textContent = "Switch to Light Mode";
    }

    function disableDarkMode() {
        document.body.classList.remove("dark-mode");
        document.querySelector("nav").classList.remove("dark-mode");
        darkModeCss.setAttribute("disabled", "true");
        localStorage.setItem("darkMode", "disabled");
        toggleButton.textContent = "Switch to Dark Mode";
    }
});