document.addEventListener("turbo:load", function() {
  const experienceList = document.getElementById("experience_list");
  const claimedExperiences = document.getElementById("claimed_experiences");
  const experienceIdsContainer = document.getElementById("experience_ids_container");
  const experienceForm = document.getElementById("experience_form");
  const experienceModal = document.getElementById("experience_modal");
  const closeModal = document.querySelector(".close");

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

    closeModal.addEventListener("click", function() {
      experienceModal.style.display = "none";
    });

    window.addEventListener("click", function(event) {
      if (event.target === experienceModal) {
        experienceModal.style.display = "none";
      }
    });
  }

});
