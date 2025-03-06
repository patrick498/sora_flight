import { Controller } from "@hotwired/stimulus"
import Swal from 'sweetalert2';
window.Swal = Swal;

// Connects to data-controller="gamebutton"
export default class extends Controller {
  static values = {
    firstAnswer: Number,
    secondAnswer: Number,
    thirdAnswer: Number,
  }

  static targets = ["button", "quiz", "dashedSquare", "firstQuestion", "secondQuestion","thirdQuestion", "hints", "hintsButton", "answer"]

  connect() {
    console.log("connected")
    this.questionNumber = 1
    console.log(this.element.children);
    this.rightAnswers = [this.firstAnswerValue, this.secondAnswerValue, this.thirdAnswerValue];

  }

  showQuiz() {
    this.captureScreenshot()
    document.querySelector("a-scene").pause()
    this.buttonTarget.classList.add("d-none"); // Hide the button
    this.quizTarget.classList.remove("d-none");// Show the content
    this.hintsButtonTarget.classList.remove("d-none"); // Show the content
    this.dashedSquareTarget.classList.add("d-none");
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
      correctAnswer = this.rightAnswers[this.questionNumber + 1];
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

  showHints(event) {
    event.currentTarget.classList.add("d-none");
    this.hintsTarget.classList.remove("d-none");
  }

  captureScreenshot() {
    const scene = document.querySelector('a-scene')
    const video = document.querySelector("video") // Get camera feed
    const canvas = scene.canvas

    if (!scene || !canvas) {
      console.error("AR.js scene, canvas not found!")
      return
    }

    // Create an offscreen canvas
    const screenshotCanvas = document.createElement("canvas")
    const ctx = screenshotCanvas.getContext("2d")

    // Match the size of the video feed
    screenshotCanvas.width = video.videoWidth || window.innerWidth
    screenshotCanvas.height = video.videoHeight || window.innerHeight

    // Draw the camera feed first (background)
    ctx.drawImage(video, 0, 0, screenshotCanvas.width, screenshotCanvas.height)

    // Convert the combined image to a data URL
    const imageUrl = screenshotCanvas.toDataURL("image/png")

    // Create an image element to show the screenshot
    const img = document.createElement("img")
    img.src = imageUrl
    img.id = "frozen-ar"
    img.style.width = "100vw"
    img.style.height = "100vh"
    img.style.position = "absolute"
    img.style.top = "0"
    img.style.left = "0"
    img.style.zIndex = "1"
    img.style.objectFit = "cover"

    // Append the frozen image
    document.body.appendChild(img)
    video.classList.add("d-none")
  }
}
