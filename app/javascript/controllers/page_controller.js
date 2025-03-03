import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="page"
export default class extends Controller {
  connect() {
  }

  removeFullscreen() {
    this.element.classList.remove("a-fullscreen")
  }
}
