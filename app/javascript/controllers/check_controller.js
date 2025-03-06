import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["icon", "wrongAnswer"];

  connect() {
    this.revealElements();
  }

  revealElements() {
    const allElements = [];
    const questionOrder = { "departure": 0, "arrival": 1, "airline": 2 };

    // Push both checkmarks & incorrect answers in order
    this.iconTargets.forEach((icon) => {
      const priority = icon.getAttribute("data-attribute-question");
      allElements.push({ element: icon, type: "checkmark", order: questionOrder[priority] });
    });

    this.wrongAnswerTargets.forEach((wrongAnswer) => {
      const priority = wrongAnswer.getAttribute("data-attribute-question");
      allElements.push({ element: wrongAnswer, type: "wrongAnswer", order: questionOrder[priority] });
    });

    // Sort by question order: Departure → Arrival → Airline
    allElements.sort((a, b) => a.order - b.order);

    // Display elements in correct order
    allElements.forEach((item, index) => {
      setTimeout(() => {
        item.element.classList.remove("hidden");
        item.element.classList.add("fade-in");

        // Apply separate animation for Airline
        if (item.element.getAttribute("data-attribute-question") === "airline") {
          item.element.style.animation = `handwriting-airline 1s ease-in-out forwards`;
        } else {
          item.element.style.animation = `handwriting 1s ease-in-out forwards`;
        }
      }, index * 1000);
    });
  }
}
