document.addEventListener("turbo:load", function() {
    document.querySelectorAll(".remove_experience").forEach(button => {
      button.addEventListener("click", function(e) {
        e.preventDefault();
        const experienceId = this.getAttribute("data-id");
  
        fetch(this.href, { method: "DELETE", headers: { "X-CSRF-Token": document.querySelector("[name='csrf-token']").content } })
          .then(response => {
            if (response.ok) {
              document.querySelector(`li[data-id='${experienceId}']`).remove();
            } else {
              alert("Failed to remove experience.");
            }
          });
      });
    });
  });
  