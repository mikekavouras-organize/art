import {observe} from 'selector-observer'
import sortable from '../../../node_modules/html5sortable/dist/html5sortable.es.js'

const preloadImage = (image, onLoad) => {
  let i = new Image()
  i.onload = onLoad
  i.src = image.src
}

const preloadImages = (images, onLoad) => {
  let count = 0
  for (const image of images) {
    preloadImage(image, () => {
      count++
      if (count == images.length) { onLoad() }
    })
  }
}

const sendForm = async form => {
  const formData = new FormData(form)
  const method = form.querySelector('[name=_method]').value
  return await fetch(form.action, {
    method: method.toUpperCase(),
    headers: { "X-Requested-With": "XMLHttpRequest" },
    body: formData
  })
}

observe('.js-file-input', {
  add(input) {
    input.addEventListener('change', async event => {
      const response = await sendForm(input.form)
      const html = await response.text()
      const div = document.createElement('div')
      div.classList.add('js-media-form')
      div.innerHTML = html.trim()

      const images = div.querySelectorAll('img')
      preloadImages(images, () => {
        document.querySelector('.js-media-form').replaceWith(div)
      })
    })
  }
})

observe('.js-sortable', {
  add(el) {
    const sortObject = sortable('.js-sortable', {
      forcePlaceholderSize: true,
      placeholderClass: 'sortable-placeholder',
      items: '.js-sortable-item',
      handle: '.handle'
    })
  }
})
