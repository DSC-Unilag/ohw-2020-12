    var desktopButton = document.getElementById("desktopButton");
    var desktopSection = document.getElementById("desktopSection");
    var changeIcon = document.getElementById("change");

    desktopButton.addEventListener('click', () => {
   desktopSection.style.display = "block";
});

    changeIcon.addEventListener('click', () => {
    desktopSection.style.display = "none";
 });
