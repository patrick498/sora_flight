import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="choice"
export default class extends Controller {
  static targets = ['hiddenInput', 'form']
  connect() {
  }
  select(event) {

    // Remove active styles from all choices
    this.element.querySelectorAll('.choice-card').forEach(card => {
      card.classList.remove('border-primary', 'bg-light');
    });

    // Add active styles to the selected choice
    let selectedCard = event.currentTarget;
    selectedCard.classList.add('border-primary', 'bg-light');

    // Update the hidden input with the selected choice ID
    this.hiddenInputTarget.value = selectedCard.dataset.choiceId;

    // Find the form element correctly and submit it
    this.element.closest("form").submit();
  }
}
