import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="reveal"
export default class extends Controller {
  static targets = ['item', 'icon'];
  connect() {
    this.revealIcons().then(() => {
      this.revealItems(); // Only run after icons are revealed
    });
  }

  revealIcons() {
    return new Promise((resolve) => {
      if (this.iconTargets.length === 0) {
        resolve(); // If no icons exist, proceed immediately
        return;
      }

      this.iconTargets.forEach((icon, index) => {
        setTimeout(() => {
          icon.classList.remove("d-none");

          // If this is the last icon, resolve the Promise after a small delay
          if (index === this.iconTargets.length - 1) {
            setTimeout(resolve, 500); // Small buffer to ensure visibility
          }
        }, index * 500); // Staggered delay for each icon
      });
    });
  }

  revealItems() {
    this.itemTargets.forEach((item, index) => {
      setTimeout(() => {
        item.classList.add("visible");
        item.classList.remove("hidden");
        item.classList.remove("d-none");

        // 🚀 Dispatch the event to trigger score animation
        item.dispatchEvent(new Event("reveal:show", { bubbles: true }));
      }, index * 1000);
    });
  }
}
