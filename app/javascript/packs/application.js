import {observe} from 'selector-observer'
import {on} from 'delegated-events'

let previewing = false

const resize = (width, height, maxWidth, maxHeight) => {
  const isVertical = width < height
  const ratio = isVertical ? maxHeight / height :  maxWidth / width
  const newHeight = height * ratio
  const newWidth = width * ratio
  return [newWidth, newHeight]
}

function showAsset(assetId) {
  hideArtDescription()

  const template = document.querySelector(`.js-asset-${assetId}`)
  const content = template.content.cloneNode(true)
  const newPiece = content.querySelector('.js-piece')

  newPiece.classList.remove('js-piece')
  newPiece.classList.add('js-visible-piece-content')

  // process metadata
  const metadata = newPiece.querySelector('.js-piece-metadata')
  const width = metadata.getAttribute('data-width')
  const height = metadata.getAttribute('data-height')
  if (width === '' || height === '') return

  const assetContainer = newPiece.querySelector('.js-asset-container')
  const widthInt = parseInt(width)
  const heightInt = parseInt(height)
  let maxHeight = 0
  if (window.innerHeight < 800) {
    maxHeight = 400
  } else if (window.innerHeight <= 1026) {
    maxHeight = 500
  } else {
    maxHeight = 640
  }
  const [newWidth, newHeight] = resize(widthInt, heightInt, 640, maxHeight)
  assetContainer.setAttribute('style', `width:${newWidth}px;height:${newHeight}px`)

  const asset = assetContainer.querySelector('.js-asset')
  asset.setAttribute('width', newWidth)
  asset.setAttribute('height', newHeight)

  const visiblePiece = document.querySelector('.js-visible-piece')
  visiblePiece.querySelector('.js-visible-piece-content').replaceWith(newPiece)
}

function showPreviousAsset() {
  if (previewing) return
  currentAssetIdx--
  if (currentAssetIdx < 0) currentAssetIdx = assetIds.length - 1
  const assetId = assetIds[currentAssetIdx % assetIds.length]
  showAsset(assetId)
}

function showNextAsset() {
  if (previewing) return
  currentAssetIdx++
  const assetId = assetIds[currentAssetIdx % assetIds.length]
  showAsset(assetId)
}

on('click', '.js-navigate-next', e => {
  showNextAsset()
})

on('click', '.js-navigate-previous', ({currentTarget}) => {
  showPreviousAsset()
})

document.addEventListener('keyup', (e) => {
  switch(e.key) {
    case "ArrowRight":
      showNextAsset();
      break;
    case "ArrowLeft":
      showPreviousAsset()
      break;
    case " ":
      if (previewing) {
        hidePreview()
      } else {
        const original = document.querySelector('.js-asset-container').querySelector('img')
        if (!original) return
        showPreview(original)
      }
      break;
  }
}, false)

on('click', '.js-menu-toggle', function() {
  const menu = document.querySelector('.js-menu')
  if (menu.classList.contains('active')) {
    menu.classList.remove('active')
    document.body.style.overflow = 'auto'
  } else {
    menu.classList.add('active')
    document.body.style.overflow = 'hidden'
  }
})

function hideArtDescription() {
  const nodes = document.querySelectorAll('.js-piece-details')
  const array = Array.from(nodes)
  const visible = array.filter(node => !node.hasAttribute('hidden'))
  if (visible[0]) {
    visible[0].remove()
  }
}

const onMouseEnter = event => {
  const { clientX, clientY, currentTarget } = event
  const details = currentTarget.querySelector('.js-piece-details').cloneNode(true)
  details.removeAttribute('hidden')
  document.body.appendChild(details)
  details.style.left = `${clientX - 310 - (clientX - currentTarget.getBoundingClientRect().left)}px`
  details.style.top = `${clientY - details.offsetHeight - 10}px`
}

const onMouseLeave = () => {
  hideArtDescription()
}

observe('.js-hover-sign', {
  add: elem => {
    elem.addEventListener('mouseenter', onMouseEnter)
    elem.addEventListener('mouseleave', onMouseLeave)
  },
  remove: elem => {
    elem.removeEventListener('mouseenter', onMouseEnter)
    elem.removeEventListener('mouseleave', onMouseLeave)
  }
})

const onFullScreen = e => {
  if (document.webkitIsFullScreen) {
    document.querySelector('.left.wall').classList.add('d-none')
  } else {
    document.querySelector('.left.wall').classList.remove('d-none')
  }
}

observe('video', {
  add: elem => {
    elem.addEventListener('webkitfullscreenchange', onFullScreen)
    elem.addEventListener('mozfullscreenchange', onFullScreen)
    elem.addEventListener('fullscreenchange', onFullScreen)
  },
  remove: elem => {
    elem.removeEventListener('webkitfullscreenchange', onFullScreen)
    elem.removeEventListener('mozfullscreenchange', onFullScreen)
    elem.removeEventListener('fullscreenchange', onFullScreen)
  }
})

const hidePreview = () => {
  if (!previewing) return
  const zoomContainer = document.querySelector('.js-zoom-container')
  if (zoomContainer) {
    zoomContainer.remove()
  }
  previewing = false
}

const showPreview = (original) => {
  if (previewing) return
  previewing = true
  const clone = original.cloneNode()

  const container = document.createElement('div')
  container.classList.add('zoom-container', 'js-zoom-container')

  clone.classList.remove('height-full')
  clone.classList.add('zoomed', 'js-zoomed')
  const [width, height] = resize(
    original.naturalWidth,
    original.naturalHeight,
    window.innerWidth * 0.8,
    window.innerHeight * 0.8
  )
  clone.setAttribute('width', width)
  clone.setAttribute('height', height)
  container.appendChild(clone)

  document.body.appendChild(container)
}

on('click', '.js-zoom-container', ({target}) => {
  hidePreview()
})

on('click', '.js-asset.image', ({target}) => {
  if (target.classList.contains('js-zoomed')) return
  showPreview(target)
})

showAsset(assetIds[0])
