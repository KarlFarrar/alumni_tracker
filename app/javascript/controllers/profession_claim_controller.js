document.addEventListener("turbo:load", function () {
  const dropdownButton = document.getElementById("dropdownButton");
  const dropdownMenu = document.getElementById("dropdownMenu");
  const professionIdsContainer = document.getElementById("profession_ids_container");
  const professionForm = document.getElementById("claim_professions_form");
  const professionModal = document.getElementById("profession_modal");
  const claimedProfessions = document.getElementById("claimed_professions");
  const professionSelect = document.getElementById("profession_select");
  const claimModal = document.getElementById("claim_profession_modal");
  const modalProfessionId = document.getElementById("modal_profession_id");
  const closeButtons = document.querySelectorAll(".modal .close");

  if (professionSelect) {
    professionSelect.addEventListener("change", function () {
      let selectedProfessionId = this.value;

      if (selectedProfessionId) {
        modalProfessionId.value = selectedProfessionId; // Set hidden input value
        claimModal.style.display = "block"; // Show the modal
      }
    });
  }

  // Close modal when clicking the 'X' button
  closeButtons.forEach(button => {
    button.addEventListener("click", function () {
      this.closest(".modal").style.display = "none";
    });
  });

  // Close modal when clicking outside the modal
  window.addEventListener("click", function (event) {
    if (event.target.classList.contains("modal")) {
      event.target.style.display = "none";
    }
  });

  // Toggle dropdown menu
  dropdownButton.addEventListener("click", function () {
    dropdownMenu.classList.toggle("show");
  });

  // Handle profession selection
  dropdownMenu.addEventListener("click", function (event) {
    const selectedItem = event.target.closest(".dropdown-item");
    if (!selectedItem) return;

    const professionId = selectedItem.getAttribute("data-value");
    const professionTitle = selectedItem.textContent;

    if (professionId === "other") {
      professionModal.style.display = "block"; // Open modal for new profession
    } else {
      modalProfessionId.value = professionId; 
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

  // Add hidden input for selected profession
  function addHiddenInput(professionId) {
    if (!document.querySelector(`input[value='${professionId}']`)) {
      const input = document.createElement("input");
      input.type = "hidden";
      input.name = "profession_ids[]";
      input.value = professionId;
      professionIdsContainer.appendChild(input);
    }
  }

  // Remove profession from claimed list
  claimedProfessions.addEventListener("click", function (event) {
    if (event.target.classList.contains("remove_profession")) {
      event.preventDefault();
      const professionId = event.target.getAttribute("data-id");
      event.target.parentElement.remove();
      removeHiddenInput(professionId);
      submitForm();
    }
  });

  // Remove hidden input when removing a profession
  function removeHiddenInput(professionId) {
    const input = professionIdsContainer.querySelector(`input[value='${professionId}']`);
    if (input) input.remove();
  }

  // Auto-submit form
  function submitForm() {
    if (professionForm) {
      professionForm.submit();
    }
  }
});
