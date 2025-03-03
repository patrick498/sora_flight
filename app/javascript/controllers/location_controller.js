import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="location"
export default class extends Controller {
  static targets = ["submitButton", "latitude", "longitude"];
// if you see this, it's just a temp fix on Yu's computer, IGNORE
  connect() {
    const latitude = Number(localStorage.getItem("latitude"))
    const longitude = Number(localStorage.getItem("longitude"))
    if (latitude && longitude) {
      this.latitudeTarget.value = latitude;
      this.longitudeTarget.value = longitude;
      this.submitButtonTarget.submit();
    } else {
      this.getLocation();
    }
  }

  getLocation() {
    if ("geolocation" in navigator) {

      navigator.geolocation.getCurrentPosition(
        (position) => {
          const { latitude, longitude } = position.coords;
          this.latitudeTarget.value = latitude;
          this.longitudeTarget.value = longitude;
          localStorage.setItem("latitude", latitude)
          localStorage.setItem("longitude", longitude)
          console.log(this.submitButtonTarget)
          this.submitButtonTarget.submit();
        },
        (error) => {
          console.error("Error getting location:", error);
        }
      );
    } else {
      console.error("Geolocation not supported.");
    }
  }
}
