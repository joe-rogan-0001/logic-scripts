import { createOptions } from "./createOptions.js";

const optionsWrapper = document.getElementById("options-wrapper");
const body = document.body;
const eye = document.getElementById("eyeSvg");

window.addEventListener("message", (event) => {
  switch (event.data.event) {
    case "visible": {
      optionsWrapper.innerHTML = "";
      eye.className = 'fa-solid fa-circle';
      eye.style.fontSize = '0.5vh';
      eye.style.color = 'rgba(255, 255, 255, 1)';
      body.style.visibility = event.data.state ? "visible" : "hidden";
      if (!event.data.state) $('#options-wrapper').hide();
      return eye.classList.remove("eye-hover");
    }

    case "leftTarget": {
      optionsWrapper.innerHTML = "";
      eye.className = 'fa-solid fa-circle';
      eye.style.fontSize = '0.5vh';
      eye.style.color = 'rgba(255, 255, 255, 1)';
      return eye.classList.remove("eye-hover");
    }
    case "ClickEvent": {
      return $('#options-wrapper').fadeIn();
    }
    case "setTarget": {
      optionsWrapper.innerHTML = "";
      eye.classList.add("eye-hover");
      if (event.data.options) {
        for (const type in event.data.options) {
          event.data.options[type].forEach((data, id) => {
            if (id == 0) {
              eye.className = data.icon;
              eye.style.fontSize = '3vh';
              eye.style.color = 'rgba(97, 163, 185, 1)';
            }
            createOptions(type, data, id + 1);
          });
        }
      }
      
      if (event.data.zones) {
        for (let i = 0; i < event.data.zones.length; i++) {
          event.data.zones[i].forEach((data, id) => {
            if (id == 0) {
              eye.className = data.icon;
              eye.style.fontSize = '3vh';
              eye.style.color = 'rgba(97, 163, 185, 1)';
            }
            createOptions("zones", data, id + 1, i + 1);
          });
        }
      }
    }
  }
});