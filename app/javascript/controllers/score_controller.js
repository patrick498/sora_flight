import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="score"
export default class extends Controller {
  static values = { target: Number, duration: Number }
  connect() {
    if (!this.element.closest("[data-reveal-target]")?.classList.contains("hidden")) {
      this.animateScore();
    }

    this.element.closest("[data-reveal-target]")?.addEventListener("reveal:show", () => {
      this.animateScore();
    });
  }

  animateScore() {
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
