import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    document.body.classList.add("overflow-hidden")
  }

  disconnect() {
    document.body.classList.remove("overflow-hidden")
  }

  close() {
    this.remove()
  }

  closeByBackdrop(event) {
    if (event.target === this.element) this.remove()
  }

  closeByEsc(event) {
    if (event.key === "Escape") this.remove()
  }

  remove() {
    this.element.remove()
  }
}
