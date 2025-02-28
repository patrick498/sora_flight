import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="location"
export default class extends Controller {
  static targets = ["submitButton", "latitude", "longitude"];

  connect() {
    this.getLocation();
  }

  getLocation() {
    if ("geolocation" in navigator) {

      navigator.geolocation.getCurrentPosition(
        (position) => {
          const { latitude, longitude } = position.coords;
          this.latitudeTarget.value = latitude;
          this.longitudeTarget.value = longitude;
          console.log(this.submitButtonTarget)
          this.submitButtonTarget.submit();
        },
        (error) => {
          console.error("Error getting location:", error);
        }
      );
    } else {
      console.error("Geolocation not supported.");
      alert()
    }
  }
}
