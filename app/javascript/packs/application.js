import {observe} from 'selector-observer'
import {on} from 'delegated-events'

function doTheThing(assetId) {
  const template = document.querySelector(`.js-asset-${assetId}`)
  const content = template.content.cloneNode(true)
  const newPiece = content.querySelector('.js-piece')
  const visiblePiece = document.querySelector('.js-visible-piece')
  visiblePiece.querySelector('.js-visible-piece-content').replaceWith(newPiece)

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
}

on('click', '.js-navigate-next', e => {
  e.preventDefault()
  currentAssetIdx++
  const assetId = assetIds[currentAssetIdx % assetIds.length]
  doTheThing(assetId)
})

on('click', '.js-navigate-previous', ({currentTarget}) => {
  currentAssetIdx--
  if (currentAssetIdx < 0) currentAssetIdx = assetIds.length - 1
  const assetId = assetIds[currentAssetIdx % assetIds.length]
  doTheThing(assetId)
})

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

while (!assetIds) {}
doTheThing(assetIds[0])
