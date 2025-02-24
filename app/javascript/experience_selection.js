document.addEventListener("turbo:load", function() { 
    const experienceList = document.getElementById("experience_list");
    const selectedExperiences = document.getElementById("selected_experiences");
    const experienceIdsField = document.getElementById("experience_ids");
  
    if (experienceList && selectedExperiences) {
      experienceList.addEventListener("dblclick", function(e) {
        const selectedOption = e.target;
        const experienceId = selectedOption.value;
        const experienceTitle = selectedOption.textContent;
  
        if (!document.querySelector(`li[data-id='${experienceId}']`)) {
          const listItem = document.createElement("li");
          listItem.setAttribute("data-id", experienceId);
          listItem.innerHTML = `${experienceTitle} <a href="#" class="remove_experience">Remove</a>`;
  
          selectedExperiences.appendChild(listItem);
          updateHiddenField();
        }
      });
  
      selectedExperiences.addEventListener("click", function(e) {
        if (e.target.classList.contains("remove_experience")) {
          e.preventDefault();
          e.target.parentElement.remove();
          updateHiddenField();
        }
      });
  
      function updateHiddenField() {
        const selectedIds = Array.from(selectedExperiences.querySelectorAll("li")).map(li => li.getAttribute("data-id"));
        experienceIdsField.value = selectedIds.join(",");
      }
    }
  });
  