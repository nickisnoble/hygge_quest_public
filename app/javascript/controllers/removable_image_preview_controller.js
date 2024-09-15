import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  remove(event) {
    event.preventDefault();
    const confirmed = confirm("Are you sure?");
    const imageId = event.target.dataset.imageId;
    if (confirmed) {
      this.element.style.display = 'none';
      this.markForRemoval(imageId);
    }
  }

  markForRemoval(imageId) {
    const input = document.createElement('input');
    input.type = 'hidden';
    input.name = 'remove_looks[]';
    input.value = imageId;
    this.element.appendChild(input);
  }
}
