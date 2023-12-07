import tinymce from 'tinymce/tinymce'

import { Controller } from '@hotwired/stimulus'
export default class extends Controller {
  static targets = ['input']

  initialize() {
    this.defaults = {
      base_url: '/assets/tinymce',
      plugins:
        'preview importcss autolink autosave save directionality code visualblocks visualchars fullscreen image link media table charmap pagebreak nonbreaking anchor advlist lists help charmap quickbars',
      menubar: 'file edit view insert format tools table',
      toolbar:
        'undo redo | bold italic underline strikethrough | fontselect fontsizeselect formatselect | alignleft aligncenter alignright alignjustify | outdent indent |  numlist bullist preview | forecolor backcolor removeformat | pagebreak | charmap | insertfile image media link anchor | ltr rtl fullscreen',
      toolbar_sticky: true,
      images_upload_url: '/uploads/image',
      file_picker_types: 'file image media',
      suffix: '.min',
      relative_urls: false,
      promotion: false,
      skin: (this.isDark() ? 'oxide-dark' : 'oxide'),
      content_css: (this.isDark() ? 'dark' : 'default')
    }
  }

  connect() {
    // Initialize the app
    let config = Object.assign({ target: this.inputTarget }, this.defaults)
    tinymce.init(config)
    this.listener()
  }

  disconnect() {
    tinymce.remove()
  }

  listener() {
    document.body.addEventListener('click', e => {
      if (e.target.name === 'commit') {
        tinyMCE.triggerSave()
      }
    })
  }

  isDark() {
    return window.localStorage.getItem('theme') === 'dark'
  }
}
