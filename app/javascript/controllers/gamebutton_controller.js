import { Controller } from "@hotwired/stimulus"
import Swal from 'sweetalert2';
window.Swal = Swal;

// Connects to data-controller="gamebutton"
export default class extends Controller {
  static values = {
    firstAnswer: Number,
    secondAnswer: Number,
    thirdAnswer: Number,
    flightId: Number,
    flights: Array,
    flightCount: Number
  }

  static targets = ["button", "quiz", "dashedSquare", "firstQuestion", "secondQuestion", "thirdQuestion", "answer"]

  connect() {
    console.log("connected");
    this.questionNumber = 1
    this.rightAnswers = [this.flightsValue[this.flightCountValue - 1].first_answer, this.flightsValue[this.flightCountValue - 1].second_answer, this.flightsValue[this.flightCountValue - 1].third_answer];
    console.log(this.rightAnswers)
  }

  startGame(event) {
    this.showQuiz();
    // show information for the plane (do this work? Add elements after it is already loaded? Should I reload?)
    this.hideAirplanes();
    this.showAirports();
    this.showArrows();
    this.showDistances();
  }

  hideAirplanes() {
    const airplanes = this.element.querySelectorAll('.airplane');
    airplanes.forEach(airplane => {
      const id = airplane.getAttribute('data-id');
      if (this.flightIdValue != id) {
        airplane.setAttribute("visible", "false");
      }
    });
  }

  showAirports() {
    const airports = this.element.querySelectorAll('.airport');
    airports.forEach(airport => {
      const id = airport.getAttribute('data-id');
      if (this.flightIdValue == id) {
        airport.setAttribute("scale", "1 1 1");
      }
    });
  }

  showArrows() {
    const arrows = this.element.querySelectorAll('.arrow');
    console.log(arrows);
    arrows.forEach(arrow => {
      const id = arrow.getAttribute('data-id');
      if (this.flightIdValue == id) {
        arrow.setAttribute("scale", "20 60 20");
      }
    });
  }

  showDistances() {
    const distances = this.element.querySelectorAll('.distance');
    distances.forEach(distance => {
      const id = distance.getAttribute('data-id');
      if (this.flightIdValue == id) {
        distance.setAttribute("scale", "25 25 25");
      }
    });
  }

  showQuiz() {
    this.buttonTarget.classList.add("d-none"); // Hide the button
    this.quizTarget.classList.remove("d-none");// Show the content
  }

  next() {
    console.log("Next");
    //increment the a number
    this.questionNumber += 1;
    //hide all question html elements
    const questions = [this.firstQuestionTarget, this.secondQuestionTarget, this.thirdQuestionTarget];
    questions.forEach((question) => {
      question.classList.add("d-none")
    })
    //Show the curent quesstion
    questions[this.questionNumber - 1].classList.remove("d-none")
  }

  checkAnswer(e) {
    const selectedValue = e.currentTarget.value;
    const selectedAnswer = e.currentTarget.closest('.arrival-airport-item');

    let isCorrect;
    let correctAnswer;

    isCorrect = false;
    if (Number(selectedValue) === this.rightAnswers[this.questionNumber - 1]) {
      isCorrect = true;
      correctAnswer = this.rightAnswers[this.questionNumber - 1];
    }
    console.log(this.questionNumber, Number(selectedValue));


    if (isCorrect) {
      selectedAnswer.classList.add('correct');
      Swal.fire({
        icon: "success",
        customClass: {
          icon: 'big-colorful-correct',  // Custom class for the icon
        },
        background: 'transparent',
        showConfirmButton: false,
        timer: 1500,
      });

    } else {
      selectedAnswer.classList.add('incorrect');
      Swal.fire({
        icon: "error",
        customClass: {
          icon: 'wrong-icon',  // Custom class for the icon
        },
        background: 'transparent',
        showConfirmButton: false,
        timer: 1500,
      });

      this.answerTargets.forEach((answerTarget) => {
        const answerValue = answerTarget.value;
        /* console.log([this.firstAnswerValue, this.secondAnswerValue, this.thirdAnswerValue], Number(answerValue));
        console.log([this.firstAnswerValue, this.secondAnswerValue, this.thirdAnswerValue].includes(Number(answerValue))); */

        if (Number(answerValue) === this.rightAnswers[this.questionNumber + 1]) {
          answerTarget.parentElement.classList.add("correct");
        }
      })
    }
    // third question, submit form
    if (e.currentTarget.name === 'game[airline_guess_id]') {
      const form = e.currentTarget.form
      setTimeout(() => {
        form.submit()
/*         this.next()
 */      }, 3500);
    } else {
      setTimeout(() => {
        this.answerTargets.forEach((answerTarget) => {
          const answerValue = answerTarget.value;
          console.log(answerValue);

          if (Number(answerValue) === this.rightAnswers[this.questionNumber + 1]) {
            answerTarget.parentElement.classList.remove("correct");
          }
        })
        this.next();
      }, 3000);
    }


  }
}
