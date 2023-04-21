import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="countries"
export default class extends Controller {
  
  connect() {
    console.log("Connected")
    
  }
  autosubmit(event){
    

    // const selectedState=this.element.options[this.element.selectedIndex]
    console.log(event)
    // const city=document.getElementById("select_city").children=
    
  }
}
