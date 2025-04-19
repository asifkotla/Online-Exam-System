window.addEventListener("pageshow", function (event) {
    // Hide loader when coming back via back/forward
    document.getElementById("myCustomLoader").style.display = "none";
});

window.onload = function () {
    // Also ensure loader is hidden when page loads
    document.getElementById("myCustomLoader").style.display = "none";

    var searchBox = document.getElementById('<%= SearchBox.ClientID %>');
    if (searchBox) {
        searchBox.addEventListener('keyup', function () {
            showLoader();
            triggerSearchPostBack();
        });
    }
};
