import {observe} from 'selector-observer'
import {on} from 'delegated-events'

function doTheThing(assetId) {
  const galleryImage = document.querySelector('.js-gallery-image')
  const template = document.querySelector(`.js-asset-${assetId}`)
  const image = template.content.querySelector('img')
  document.querySelector('.js-gallery-image img').src = image.src
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
