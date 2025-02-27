import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="gamebutton"
export default class extends Controller {
  static targets = ["button", "quiz"]

  connect() {
    console.log("connected")
  }

  showQuiz() {
    console.log("Clicked")
    this.buttonTarget.classList.add("d-none"); // Hide the button
    this.quizTarget.classList.remove("d-none"); // Show the content
  }
}
