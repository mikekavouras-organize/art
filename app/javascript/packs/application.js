import {observe} from 'selector-observer'

const preloadImage = (image, onLoad) => {
  let i = new Image()
  i.onload = onLoad
  i.src = image.src
}

const preloadImages = (images, onLoad) => {
  let count = 0
  for (const image of images) {
    preloadImage(image, () => {
      console.log('loaded')
      count++
      if (count == images.length) { onLoad() }
    })
  }
}

observe('.js-file-input', {
  add(input) {
    input.addEventListener('change', async event => {
      const formData = new FormData(input.form)
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

      const images = div.querySelectorAll('img')
      preloadImages(images, () => {
        document.querySelector('.js-media-form').replaceWith(div)
      })
    })
  }
})
