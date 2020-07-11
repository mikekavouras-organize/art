import {observe} from 'selector-observer'
import {on} from 'delegated-events'

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
  const maxHeight = window.innerHeight <= 1026 ? 500 : 640
  const maxWidth = 640
  const isVertical = widthInt < heightInt
  const ratio = isVertical ? maxHeight / heightInt :  maxWidth / widthInt
  const newHeight = heightInt * ratio
  const newWidth = widthInt * ratio
  assetContainer.setAttribute('style', `width:${newWidth}px;height:${newHeight}px`)

  const asset = assetContainer.querySelector('.js-asset')
  asset.setAttribute('width', newWidth)
  asset.setAttribute('height', newHeight)

  const visiblePiece = document.querySelector('.js-visible-piece')
  visiblePiece.querySelector('.js-visible-piece-content').replaceWith(newPiece)
}

function showPreviousAsset() {
  currentAssetIdx--
  if (currentAssetIdx < 0) currentAssetIdx = assetIds.length - 1
  const assetId = assetIds[currentAssetIdx % assetIds.length]
  showAsset(assetId)
}

function showNextAsset() {
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

showAsset(assetIds[0])
