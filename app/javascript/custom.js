import * as bootstrap from "bootstrap";

document.addEventListener("turbo:load", function () {
  console.log("custom.js foi carregado!");
  alert("custom.js carregado com sucesso! 🚀");

  let dropdowns = document.querySelectorAll(".dropdown.text-end");

  dropdowns.forEach((dropdown) => {
    let toggle = dropdown.querySelector(".dropdown-toggle");

    if (toggle) {
      toggle.addEventListener("click", function (event) {
        event.preventDefault();
        let dropdownMenu = new bootstrap.Dropdown(toggle);
        dropdownMenu.toggle();
      });
    }
  });
});
