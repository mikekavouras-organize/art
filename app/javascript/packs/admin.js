import {observe} from 'selector-observer'
import {on} from 'delegated-events'
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
  const method = form.method

  return await fetch(form.action, {
    method: method.toUpperCase(),
    headers: { "X-Requested-With": "XMLHttpRequest" },
    body: formData
  })
}

observe('.js-file-input', {
  add(input) {
    input.addEventListener('change', async event => {
      document.querySelector('.js-add-media-btn').classList.add('disabled')
      document.querySelector('.js-new-media-loader').style.display = 'block'

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
    })[0]

    sortObject.addEventListener('sortupdate', function(event) {
      const items = event.target.querySelectorAll('.js-sortable-item')
      const ids = Array.from(items).map(item => item.getAttribute('data-id'))
      const input = document.querySelector('.js-positions')
      input.value = ids.join(',')
      sendForm(input.form)
    })
  }
})

on('click', '.js-series-delete', event => {
  let { currentTarget } = event
  let form = currentTarget.parentNode
  if (confirm("Delete this media?")) {
    form.submit()
  }
});
