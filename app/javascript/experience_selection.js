document.addEventListener("turbo:load", function () {
  // Experience Elements
  const dropdownButton = document.getElementById("experienceDropdownButton");
  const dropdownMenu = document.getElementById("experienceDropdown");
  const experienceIdsContainer = document.getElementById("experience_ids_container");
  const experienceForm = document.getElementById("claim_experiences_form");
  const experienceModal = document.getElementById("experience_modal");
  const claimModal = document.getElementById("claim_experience_modal");
  const modalExperienceId = document.getElementById("modal_experience_id");
  const placementField = document.getElementById("placement_field");
  const closeButtons = document.querySelectorAll(".modal .close");
  const experienceList = document.getElementById("experienceList");
  const searchInput = document.getElementById("searchExpInput");
  const dropdownItems = document.querySelectorAll(".dropdown-item");
  const otherOption = document.querySelector('.dropdown-item[data-value="other-exp"]');

  // Toggle dropdown menu
  dropdownButton.addEventListener("click", function (e) {
    e.stopPropagation();
    dropdownMenu.classList.toggle("show");
  });

  // Search functionality while keeping "Other" always visible
  searchInput.addEventListener("keyup", function() {
    let filter = searchInput.value.toLowerCase();

    dropdownItems.forEach(item => {
      let text = item.textContent.toLowerCase();
      if (item === otherOption || text.includes(filter)) {
        item.style.display = ""; // Show matching items & "Other"
      } else {
        item.style.display = "none"; // Hide non-matching items
      }
    });
  });

  // Handle experience selection
  dropdownMenu.addEventListener("click", function (event) {
    const selectedItem = event.target.closest(".dropdown-item");
    if (!selectedItem) return;

    const experienceId = selectedItem.getAttribute("data-value");
    const experienceTitle = selectedItem.textContent.trim();

    // Handle placement field visibility
    if (experienceTitle.toLowerCase().includes("competition")) {
      placementField.style.display = "block";
    } else {
      placementField.style.display = "none";
    }

    if (experienceId === "other-exp") {
      experienceModal.style.display = "block";
      experienceList.value = "";
      
    } else {
      modalExperienceId.value = experienceId;
      claimModal.style.display = "block";
    }

    dropdownMenu.classList.remove("show");
  });

  // Close dropdown when clicking outside
  document.addEventListener("click", function (event) {
    if (!dropdownButton.contains(event.target) && !dropdownMenu.contains(event.target)) {
      dropdownMenu.classList.remove("show");
    }
  });

  // Close modals
  closeButtons.forEach(button => {
    button.addEventListener("click", function () {
      this.closest(".modal").style.display = "none";
    });
  });

  window.addEventListener("click", function (event) {
    if (event.target.classList.contains("modal")) {
      event.target.style.display = "none";
    }
  });

  // Handle removal of claimed experiences
  const claimedExperiences = document.getElementById("claimed_experiences");
  if (claimedExperiences) {
    claimedExperiences.addEventListener("click", function (event) {
      if (event.target.classList.contains("remove_experience")) {
        event.preventDefault();
        const experienceId = event.target.getAttribute("data-id");
        event.target.parentElement.remove();
        removeHiddenInput(experienceId);
        submitForm();
      }
    });
  }

  // Hidden input management
  function addHiddenInput(experienceId) {
    if (!document.querySelector(`input[value='${experienceId}']`)) {
      const input = document.createElement("input");
      input.type = "hidden";
      input.name = "experience_ids[]";
      input.value = experienceId;
      experienceIdsContainer.appendChild(input);
    }
  }

  function removeHiddenInput(experienceId) {
    const input = experienceIdsContainer.querySelector(`input[value='${experienceId}']`);
    if (input) input.remove();
  }

  function submitForm() {
    if (experienceForm) {
      experienceForm.submit();
    }
  }
});
