import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="reveal"
export default class extends Controller {
  static targets = ['item'];
  connect() {
    console.log('hello');
    console.log(this);

    this.revealItems();
  }

  revealItems() {
    this.itemTargets.forEach((item, index) => {
      setTimeout(() => {
        item.classList.add('visible')
      }, index * 1500);
    });
  }
}
