import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="score"
export default class extends Controller {
  static values = { target: Number, duration: Number }
  connect() {
    console.log("Score controller connected.");

    // Ensure the element is listening for reveal:show
    const revealTarget = this.element.closest("[data-reveal-target]");

    if (revealTarget) {
      revealTarget.addEventListener("reveal:show", () => {
        console.log("reveal:show event received, triggering animateScore.");
        this.animateScore();
      });

      // If the element is already visible when connected, trigger animation
      if (!revealTarget.classList.contains("hidden")) {
        console.log("Element already visible, triggering animateScore.");
        this.animateScore();
      }
    } else {
      console.warn("No reveal target found for score controller.");
    }
  }

  animateScore() {
    console.log('inside animate score');

    let start = 0;
    let end = this.targetValue;
    let duration = this.durationValue || 2000; // Default duration: 2s

    let frameRate = 60; // Smooth 60 FPS animation
    let totalFrames = (duration / 1000) * frameRate; // Convert ms to frames
    let increment = end / totalFrames; // Adjust increment size

    let current = start;
    let frame = 0;

    let timer = setInterval(() => {
      current += increment;
      frame++;

      if (frame >= totalFrames) {
        current = end;
        clearInterval(timer);
      }

      this.element.textContent = Math.round(current);
    }, 1000 / frameRate);
  }
}
