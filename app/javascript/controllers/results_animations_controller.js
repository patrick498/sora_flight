import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="results-animations"
export default class extends Controller {
  connect() {
    this.showPlane();
  }
  showPlane() {
    const airplane = document.querySelector('.airplane')
    if (airplane) airplane.classList.add('fly');
  }
}
