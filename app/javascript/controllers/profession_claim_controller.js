document.addEventListener("turbo:load", function() {
  const professionList = document.getElementById("profession_list");
  const claimedProfessions = document.getElementById("claimed_professions");
  const professionIdsContainer = document.getElementById("profession_ids_container");
  const professionForm = document.getElementById("claim_profession_form");
  const professionModal = document.getElementById("profession_modal");
  const claimModal = document.getElementById("claim_profession_modal");
  const professionIdInput = document.getElementById("modal_profession_id");
  const closeButtons = document.querySelectorAll(".close");

  // ✅ Add Logging for Debugging
  console.log("JavaScript loaded for professions");

  // ✅ Close modal logic
  closeButtons.forEach(button => {
    button.addEventListener("click", function () {
      const modal = this.closest(".modal");
      if (modal) modal.style.display = "none";
    });
  });

  // ✅ Handle "Other" selection to open modal
  if (professionList && professionModal) {
    professionList.addEventListener("change", function(e) {
      console.log("Profession list change detected"); // ✅ Debugging line
      if (e.target.value === "other") {
        professionModal.style.display = "block";
        professionList.value = ""; // Reset dropdown after opening modal
      }
    });

    window.addEventListener("click", function(event) {
      if (event.target === professionModal) {
        professionModal.style.display = "none";
      }
    });
  }

  // ✅ Handle double-click to claim a profession
  if (professionList && claimedProfessions) {
    professionList.addEventListener("dblclick", function(e) {
      console.log("Profession double-clicked"); // ✅ Debugging line

      const selectedOption = e.target;
      const professionId = selectedOption.value;
      const professionTitle = selectedOption.textContent;

      if (professionId === "other") {
        professionModal.style.display = "block";
        professionList.value = "";
      } else if (!document.querySelector(`li[data-id='${professionId}']`)) {
        console.log(`Claiming profession with ID: ${professionId}`); // ✅ Debugging line

        // Add to list
        const listItem = document.createElement("li");
        listItem.setAttribute("data-id", professionId);
        listItem.innerHTML = `
          <strong>${professionTitle}</strong> <br>
          <a href="#" class="remove_profession" data-id="${professionId}">Remove</a>
        `;
        claimedProfessions.appendChild(listItem);

        addHiddenInput(professionId);
        submitForm(); // ✅ Trigger form submission
      }
    });

    // ✅ Remove claimed profession
    claimedProfessions.addEventListener("click", function(e) {
      if (e.target.classList.contains("remove_profession")) {
        e.preventDefault();
        const professionId = e.target.getAttribute("data-id");
        e.target.parentElement.remove();
        removeHiddenInput(professionId);
        submitForm();
      }
    });

    function addHiddenInput(professionId) {
      console.log(`Adding hidden input for profession: ${professionId}`); // ✅ Debugging line

      const input = document.createElement("input");
      input.type = "hidden";
      input.name = "profession_ids[]";
      input.value = professionId;
      professionIdsContainer.appendChild(input);
    }

    function removeHiddenInput(professionId) {
      console.log(`Removing hidden input for profession: ${professionId}`); // ✅ Debugging line

      const input = professionIdsContainer.querySelector(`input[value='${professionId}']`);
      if (input) input.remove();
    }

    function submitForm() {
      console.log("Submitting form"); // ✅ Debugging line

      if (professionForm) {
        professionForm.submit();
      }
    }
  }

  // ✅ Open claim modal for profession details
  if (professionList && claimModal) {
    professionList.addEventListener("dblclick", function(e) {
      const selectedOption = e.target;
      if (selectedOption.value) {
        console.log(`Opening claim modal for ID: ${selectedOption.value}`); // ✅ Debugging line
        professionIdInput.value = selectedOption.value;
        claimModal.style.display = "block";
        e.stopPropagation();
      }
    });

    window.addEventListener("click", function(event) {
      if (event.target === claimModal) {
        claimModal.style.display = "none";
      }
    });
  }
});
