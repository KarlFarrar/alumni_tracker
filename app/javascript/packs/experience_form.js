document.addEventListener("DOMContentLoaded", function() {
    const experienceContainer = document.getElementById("experiences");
    const addExperienceLink = document.querySelector(".add_experience");
  
    addExperienceLink.addEventListener("click", function(e) {
      e.preventDefault();
  
      const newExperience = document.createElement("div");
      newExperience.classList.add("nested-fields");
      newExperience.innerHTML = `
        <label>Experience Title</label>
        <input type="text" name="alumnus[experiences_attributes][][title]">
  
        <label>Experience Type</label>
        <input type="text" name="alumnus[experiences_attributes][][experience_type]">
  
        <label>Date Interval</label>
        <input type="text" name="alumnus[experiences_attributes][][date_interval]" placeholder="e.g., 2020-2023">
  
        <label>Description</label>
        <textarea name="alumnus[experiences_attributes][][description]"></textarea>
  
        <a href="#" class="remove_experience">Remove Experience</a>
      `;
  
      experienceContainer.appendChild(newExperience);
  
      newExperience.querySelector(".remove_experience").addEventListener("click", function(e) {
        e.preventDefault();
        newExperience.remove();
      });
    });
  
    document.querySelectorAll(".remove_experience").forEach((btn) => {
      btn.addEventListener("click", function(e) {
        e.preventDefault();
        this.parentNode.remove();
      });
    });
  });
  