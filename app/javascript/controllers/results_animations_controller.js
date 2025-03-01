import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="results-animations"
export default class extends Controller {
  static targets = ['airplane'];
  static values = { score: Number };

  connect() {
    console.log('inside the results animation controller');
    this.moveAirplane();
  }
  moveAirplane() {
    const maxMove = 100; // Maximum pixels the airplane moves up
    const moveAmount = (this.scoreValue / 100) * maxMove; // Scale movement

    // Apply transformation
    this.airplaneTarget.style.transform = `translateY(-${moveAmount}px)`;

    // Optional: Add animation
    this.airplaneTarget.style.transition = "transform 1.5s ease-out";
  }
}
