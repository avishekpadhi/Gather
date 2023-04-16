import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="countries"
export default class extends Controller {
  static targets = ["remoteBtn"]
  connect() {
    console.log("Connected")
    this.remoteBtnTarget.hidden=true
  }
  autosubmit(){
    this.remoteBtnTarget.click()
  }
}
