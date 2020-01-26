// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import {observe} from 'selector-observer'

observe('.js-file-input', {
  add(input) {
    input.addEventListener('change', async event => {
      const formData = new FormData(input.form)
      // const [file] = event.target.files
      const method = input.form.querySelector('[name=_method]').value
      const response = await fetch(input.form.action, {
        method: method.toUpperCase(),
        headers: { "X-Requested-With": "XMLHttpRequest" },
        body: formData
      })
      const html = await response.text()

      const div = document.createElement('div')
      div.classList.add('js-media-form')
      div.innerHTML = html.trim()
      document.querySelector('.js-media-form').replaceWith(div)

      input.form.reset()
    })
  }
})
