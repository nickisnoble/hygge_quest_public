import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="flash"
export default class extends Controller {
  connect() {
    const duration = 4000;
    this.element.style.animation = `fade-in-and-out ${duration}ms`;
    setTimeout(() => {
      this.element.remove()
    }, duration)
  }
}
