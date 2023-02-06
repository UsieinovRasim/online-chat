import { Controller } from "@hotwired/stimulus"
import { cable } from "@hotwired/turbo-rails"

export default class extends Controller {
  connect() {
    this.subscribe()
    this.scrollRooms()
  }

  subscribe() {
    const turboStreamFromTag = document.querySelector("turbo-cable-stream-source")
    const channelName = turboStreamFromTag.getAttribute("channel")
    const signedStreamName = turboStreamFromTag.getAttribute("signed-stream-name")

    const scrollRooms = this.scrollRooms.bind(this)

    this.channel = cable.subscribeTo({ channel: channelName, signed_stream_name: signedStreamName }, {
      received(data) {
        setTimeout(scrollRooms, 100)
      }
    })
  }

  clearInput() {
    this.element.reset()
  }

  scrollRooms() {
    const chatContainer = document.getElementById("room-container")
    if (chatContainer) chatContainer.scrollTop = chatContainer.scrollHeight
  }
}
