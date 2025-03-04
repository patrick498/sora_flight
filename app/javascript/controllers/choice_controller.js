import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="choice"
export default class extends Controller {
  static targets = ['hiddenInput', 'form']

  connect() {
    this.choices = JSON.parse(this.element.dataset.choices);
  }

  select(event) {
    // Remove active styles from all choices
    this.element.querySelectorAll('.choice-card').forEach(card => {
      card.classList.remove('border-primary', 'bg-light', 'bg-danger-subtle', 'bg-success');
    });

    // Add active styles to the selected choice
    let selectedCard = event.currentTarget;
    // selectedCard.classList.add('border-primary', 'bg-light');

    let selectedChoiceID = parseInt(selectedCard.dataset.choiceId);
    console.log('selectedChoiceID');
    console.log(selectedChoiceID);


    // Update the hidden input with the selected choice ID
    this.hiddenInputTarget.value = selectedChoiceID;

    console.log('this.choices');
    console.log(this.choices);

    // Find the selected choice in the parsed JSON data
    let selectedChoice = this.choices.find(choice => choice.id === selectedChoiceID);
    console.log(selectedChoice);

    if (selectedChoice && !selectedChoice.correct) {
      selectedCard.classList.add('bg-danger-subtle');
    }

    // let correctChoice = this.choices.find(choice => choice.correct);
    // if correctChoice {
    //   let correctCard = this.element.querySelector()
    // }

    // this.choices.forEach((choice) => {
    //   if choice.correct {

    //   }
    // })

    // Find the form element correctly and submit it
    // this.element.closest("form").submit();
  }
}
