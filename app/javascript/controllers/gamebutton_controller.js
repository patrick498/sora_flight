import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="gamebutton"
export default class extends Controller {
  static targets = ["button", "quiz", "dashedSquare"]

  connect() {
    console.log("connected")
  }

  showQuiz() {
    this.captureScreenshot()
    document.querySelector("a-scene").pause()
    this.buttonTarget.classList.add("d-none"); // Hide the button
    this.quizTarget.classList.remove("d-none"); // Show the content
    this.dashedSquareTarget.classList.add("d-none");
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
