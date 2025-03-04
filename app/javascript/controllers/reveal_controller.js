import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="reveal"
export default class extends Controller {
  static targets = ['item', 'icon'];
  connect() {
    console.log("Loaded Reveal");
    this.revealItems();
  }

  revealItems() {
    this.itemTargets.forEach((item, index) => {
      setTimeout(() => {
        item.classList.add('visible');
        item.classList.remove('hidden');
        // 🚀 Dispatch the event to trigger score animation
        item.dispatchEvent(new Event('reveal:show', { bubbles: true }));
        const icon = item.querySelector("[data-reveal-target='icon']");
        if (icon) {
          setTimeout(() => {
            icon.classList.remove('d-none');
          }, 500);
        }
      }, index * 1000);
    });
  }

}
