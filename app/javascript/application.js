// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers/profession_claim_controller"

console.log("JS is loaded!");

document.addEventListener("turbo:load", function () {
  const profileButton = document.getElementById("navbar-profile");
  const dropdown = document.getElementById("profile-dropdown");

  profileButton.addEventListener("click", function (event) {
    event.stopPropagation(); // Prevent the document click from immediately hiding the dropdown
    dropdown.classList.toggle("hidden");
    console.log("Profile button clicked");
  });
  document.addEventListener("click", function (event) {
    if (!profileButton.contains(event.target) && !dropdown.contains(event.target)) {
      dropdown.classList.add("hidden");
    }
  }); 
});

document.addEventListener("turbo:load", function () {
  document.querySelectorAll(".flash-close").forEach(button => {
    button.addEventListener("click", function () {
      let flashMessage = this.parentElement;
      flashMessage.style.opacity = "0";
      setTimeout(() => flashMessage.style.display = "none", 300); // Smooth hide
    });
  });
});
