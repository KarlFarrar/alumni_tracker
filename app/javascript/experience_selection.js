document.addEventListener("turbo:load", function() {
  const experienceList = document.getElementById("experience_list");
  const claimedExperiences = document.getElementById("claimed_experiences");
  const experienceIdsContainer = document.getElementById("experience_ids_container");
  const experienceForm = document.getElementById("experience_form");
  const experienceModal = document.getElementById("experience_modal");
  const claimModal = document.getElementById("claim_experience_modal");
  const experienceIdInput = document.getElementById("modal_experience_id");
  const experienceTitleInput = document.getElementById("modal_experience_title"); 
  const placementField = document.getElementById("placement_field"); 
  const closeButtons = document.querySelectorAll(".close");

  // Close modal logic
  closeButtons.forEach(button => {
    button.addEventListener("click", function () {
      const modal = this.closest(".modal");
      if (modal) modal.style.display = "none";
    });
  });

  // Handle double-click to claim an experience
  if (experienceList && claimModal) {
    experienceList.addEventListener("dblclick", function(e) {
      const selectedOption = e.target;
      if (!selectedOption.value) return; // Ignore empty selections

      const experienceId = selectedOption.value;
      const experienceTitle = selectedOption.textContent;

      // Set hidden input values
      experienceIdInput.value = experienceId;
      experienceTitleInput.value = experienceTitle;

      // Check if selected experience is a "Competition"
      if (experienceTitle.toLowerCase().includes("competition")) {
        placementField.style.display = "block"; // Show placement field
      } else {
        placementField.style.display = "none"; // Hide placement field
      }

      claimModal.style.display = "block"; // Open modal
      e.stopPropagation();
    });
    
    claimedExperiences.addEventListener("click", function(e) {
      if (e.target.classList.contains("remove_experience")) {
        e.preventDefault();
        const experienceId = e.target.getAttribute("data-id");
        e.target.parentElement.remove();
        removeHiddenInput(experienceId);
        submitForm();
      }
    });

    function addHiddenInput(experienceId) {
      let input = document.createElement("input");
      input.type = "hidden";
      input.name = "experience_ids[]";
      input.value = experienceId;
      experienceIdsContainer.appendChild(input);
    }

    function removeHiddenInput(experienceId) {
      const input = experienceIdsContainer.querySelector(`input[value='${experienceId}']`);
      if (input) input.remove();
    }

    function submitForm() {
      experienceForm.submit();
    }
  }

  // Logic Behind Pop-Up. 
  if (experienceList && experienceModal) {
    experienceList.addEventListener("change", function(e) {
      if (e.target.value === "other") {
        experienceModal.style.display = "block";
        experienceList.value = ""; // Reset dropdown selection
      }
    });

    window.addEventListener("click", function(event) {
      if (event.target === experienceModal) {
        experienceModal.style.display = "none";
      }
    });
  }

  // Experience Details Logic
  if (experienceList && claimModal) {
    experienceList.addEventListener("dblclick", function(e) {
      const selectedOption = e.target;
      if (selectedOption.value) {
        experienceIdInput.value = selectedOption.value; // Store experience ID
        claimModal.style.display = "block"; 
        e.stopPropagation();
      }
    });

    // Prevent immediate form submission
    claimForm.addEventListener("submit", function(e) {
      if (!experienceIdInput.value) {
        e.preventDefault(); // Stop form submission if no experience is selected
      }
    });

    // Also close modal if user clicks outside it
    window.addEventListener("click", function(event) {
      if (event.target === claimModal) {
        claimModal.style.display = "none";
      }
    });
  }

  if (claimModal && closeModal) {
    closeModal.addEventListener("click", function() {
      claimModal.style.display = "none";
    });

    // Also close modal if user clicks outside the modal content
    window.addEventListener("click", function(event) {
      if (event.target === claimModal) {
        claimModal.style.display = "none";
      }
    });
  }

});
