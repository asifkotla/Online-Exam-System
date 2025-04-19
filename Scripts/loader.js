function showLoader() {
    var loader = document.getElementById("myCustomLoader");
    if (loader) {
        loader.style.display = "flex";
    }
}

function hideLoader() {
    var loader = document.getElementById("myCustomLoader");
    if (loader) {
        loader.style.display = "none";
    }
}
