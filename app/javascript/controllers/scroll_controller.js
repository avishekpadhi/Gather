import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    connect() {
      console.log("Connect")
      const messages = document.getElementById("messages");
      messages.addEventListener("DOMNodeInserted",this.resetScroll);
      this.resetScroll(messages)

    }
    disconnect()
    {
        console.log("Disconnect")
    }

    resetScroll(){
        messages.scrollTop=messages.scrollHeight - messages.clientHeight

    }
  }
  