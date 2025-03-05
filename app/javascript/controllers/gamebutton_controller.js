import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="gamebutton"
export default class extends Controller {
  static values = {
    firstAnswer: Number,
    secondAnswer: Number,
    thirdAnswer: Number,
  }
  static targets = ["button", "quiz", "dashedSquare", "firstQuestion", "secondQuestion","thirdQuestion"]

  connect() {
    console.log("connected")
    this.questionNumber = 1
  }

  showQuiz() {
    this.captureScreenshot()
    document.querySelector("a-scene").pause()
    this.buttonTarget.classList.add("d-none"); // Hide the button
    this.quizTarget.classList.remove("d-none"); // Show the content
    this.dashedSquareTarget.classList.add("d-none");
  }

    next(){
      console.log("Next");
      //increment the a number
      this.questionNumber += 1;
      //hide all question html elements
      const questions = [this.firstQuestionTarget,this.secondQuestionTarget,this.thirdQuestionTarget];
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

      if (selectedValue == this.firstAnswerValue) {
        isCorrect = true;
        correctAnswer = this.firstAnswerValue;
      } else if (selectedValue == this.secondAnswerValue) {
        isCorrect = true;
        correctAnswer = this.secondAnswerValue;
      } else if (selectedValue == this.thirdAnswerValue) {
        isCorrect = true;
        correctAnswer = this.thirdAnswerValue;
      } else {
        isCorrect = false;
      }

      if (isCorrect) {
        selectedAnswer.classList.add('correct');
      } else {
        selectedAnswer.classList.add('incorrect');
      }

      // third question, submit form
      if (e.currentTarget.name === 'game[airline_guess_id]') {
        e.currentTarget.form.submit()
      }

      setTimeout(() => {
        this.next();
      }, 1000);
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
