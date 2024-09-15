import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="asset-preview"
export default class extends Controller {
  update(event) {
    const input = event.target;
    const id = event.target.id;
    const file = input.files[0];

    let preview = document.querySelector(`#${id}_preview`);
    if(!preview) {
      preview = document.createElement('img');
      preview.id = `${id}_preview`;
      input.insertAdjacentElement('afterend', preview);
    }

    if (file && preview) {
      const reader = new FileReader();
      reader.onload = () => preview.src = reader.result;
      reader.readAsDataURL(file);
    }
  }
}