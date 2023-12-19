import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
  static targets = ['notice', 'container']

  initialize() { }

  connect() {
    this.toaster()
  }

  disconnect() { }

  toaster() {
    if (this.hasNoticeTarget) {
      this.noticeTargets.forEach((notice) => {
        const toastBootstrap = window.bootstrap.Toast.getOrCreateInstance(notice)
        toastBootstrap.show()
      })
    }
  }
}
