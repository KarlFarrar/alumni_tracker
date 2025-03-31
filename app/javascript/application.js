// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers/profession_claim_controller"

console.log("JS is loaded!");

document.addEventListener("DOMContentLoaded", function () {
  const profileButton = document.getElementById("navbar-profile");
  const dropdown = document.getElementById("profile-dropdown");

  profileButton.addEventListener("click", function () {
    dropdown.classList.toggle("hidden");
  });

  document.addEventListener("click", function (event) {
    if (!profileButton.contains(event.target) && !dropdown.contains(event.target)) {
      dropdown.classList.add("hidden");
    }
  });
});
