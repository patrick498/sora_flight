import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["icon", "wrongAnswer"];

  connect() {
    this.adjustAirlineFontSize(); // Ensure font size is set on load
    this.revealElements();
  }

  adjustAirlineFontSize() {
    const airlineElement = document.querySelector(".airline");
    const airlineCorrectElement = document.querySelector(".airline-correct-answer");

    if (airlineElement) {
      const textLength = airlineElement.textContent.trim().length;
      if (textLength > 12) {
        airlineElement.style.fontSize = "24px"; // Very long names
      } else {
        airlineElement.style.fontSize = "32px"; // Default size
      }
    }

    if (airlineCorrectElement) {
      const textLength = airlineCorrectElement.textContent.trim().length;
      if (textLength > 12) {
        airlineCorrectElement.style.fontSize = "28px"; // Very long names
      } else {
        airlineCorrectElement.style.fontSize = "36px"; // Default size
      }
    }
  }

  revealElements() {
    const allElements = [];
    const questionOrder = { "departure": 0, "arrival": 1, "airline": 2 };

    // Push checkmarks & incorrect answers
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

    const animationDelay = 1000;
    const totalCheckAnswerTime = allElements.length * animationDelay;

    // Reveal checkmarks and correct/incorrect answers
    allElements.forEach((item, index) => {
      setTimeout(() => {
        item.element.classList.remove("hidden");
        item.element.classList.add("fade-in");

        if (item.type !== "stamp") {
          if (item.element.getAttribute("data-attribute-question") === "airline") {
            item.element.style.animation = `handwriting-airline 1s ease-in-out forwards`;
          } else {
            item.element.style.animation = `handwriting 1s ease-in-out forwards`;
          }
        }
      }, index * animationDelay);
    });

    // 1️⃣ Start Miles Animation (Reduced to 2s for Faster Transition)
    const milesAnimationTime = 2000;
    setTimeout(() => {
      this.animateMiles();
    }, totalCheckAnswerTime);

    // 2️⃣ Instantly Show Cabin Class *Immediately After* Miles Ends
    setTimeout(() => {
      const cabinClassElement = document.querySelector(".cabin-class");
      if (cabinClassElement) {
        cabinClassElement.classList.remove("hidden");
      }
    }, totalCheckAnswerTime + milesAnimationTime); // Show immediately after miles

    // 3️⃣ Start Badge Animation (Much Sooner After Miles)
    const badgeImages = document.querySelectorAll(".new-badges img");

    setTimeout(() => {
      badgeImages.forEach((badge, index) => {
        setTimeout(() => {
          badge.classList.add("stamp");
        }, index * 200); // Reduced stagger from 300ms to 200ms
      });
    }, totalCheckAnswerTime + milesAnimationTime + 100); // Shorter delay after cabin class
  }

  animateMiles() {
    const milesElement = document.querySelector(".miles-earned");
    if (!milesElement) return;

    const finalMiles = parseInt(milesElement.getAttribute("data-miles-earned"), 10);
    let currentMiles = 0;

    const stepTime = 30; // Faster updates
    const totalDuration = 2000; // Faster completion (2s)
    const step = Math.ceil(finalMiles / (totalDuration / stepTime));

    const interval = setInterval(() => {
      currentMiles += step;
      if (currentMiles >= finalMiles) {
        currentMiles = finalMiles;
        clearInterval(interval);
      }
      milesElement.textContent = currentMiles;
    }, stepTime);
  }

}
