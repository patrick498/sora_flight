import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["item", "icon", "badges"];

  connect() {
    this.revealIcons().then(() => {
      this.revealItems(); // Only run after icons are revealed
    });
  }

  revealIcons() {
    return new Promise((resolve) => {
      if (this.iconTargets.length === 0) {
        resolve();
        return;
      }

      this.iconTargets.forEach((icon, index) => {
        setTimeout(() => {
          icon.classList.remove("d-none");

          if (index === this.iconTargets.length - 1) {
            setTimeout(resolve, 500);
          }
        }, index * 500);
      });
    });
  }

  revealItems() {
    this.itemTargets.forEach((item, index) => {
      setTimeout(() => {
        item.classList.add("visible");
        item.classList.remove("hidden");
        item.classList.remove("d-none");

        // Dispatch event to trigger score animation
        item.dispatchEvent(new Event("reveal:show", { bubbles: true }));
      }, index * 1000);
    });

    // Listen for when the score animation is done
    document.addEventListener("score:done", () => {
      this.showBadges();
    });
  }

  showBadges() {
    if (this.hasBadgesTarget) {
      this.badgesTarget.classList.remove("d-none");
    }
  }
}
