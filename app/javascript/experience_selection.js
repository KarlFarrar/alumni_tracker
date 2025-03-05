document.addEventListener("turbo:load", function() {
  const experienceList = document.getElementById("experience_list");
  const claimedExperiences = document.getElementById("claimed_experiences");
  const experienceIdsContainer = document.getElementById("experience_ids_container");
  const experienceForm = document.getElementById("experience_form");
  const experienceModal = document.getElementById("experience_modal");
  const claimModal = document.getElementById("claim_experience_modal");
  const experienceIdInput = document.getElementById("modal_experience_id");
  const closeButtons = document.querySelectorAll(".close");

  // Loop through each close button and add event listener
  closeButtons.forEach(button => {
    button.addEventListener("click", function() {
      const modal = this.closest(".modal"); // Find the closest modal
      if (modal) {
        modal.style.display = "none"; 
      }
    });
  });

  if (experienceList && claimedExperiences) {
    experienceList.addEventListener("dblclick", function(e) {
      const selectedOption = e.target;
      const experienceId = selectedOption.value;
      const experienceTitle = selectedOption.textContent;

      if (!document.querySelector(`li[data-id='${experienceId}']`)) {
        const listItem = document.createElement("li");
        listItem.setAttribute("data-id", experienceId);
        listItem.innerHTML = `
          <strong>${experienceTitle}</strong> <br>
          <a href="#" class="remove_experience" data-id="${experienceId}">Remove</a>
        `;

        claimedExperiences.appendChild(listItem);
        addHiddenInput(experienceId);
        submitForm();
      }
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
