import {observe} from 'selector-observer'
import {on} from 'delegated-events'

function doTheThing(assetId) {
  const galleryImage = document.querySelector('.js-gallery-image')
  const template = document.querySelector(`.js-asset-${assetId}`)
  const image = template.content.querySelector('img')
  const seriesTitle = template.content.querySelector('.js-title').textContent
  const seriesDescription = template.content.querySelector('.js-description').textContent
  document.querySelector('.js-gallery-image img').src = image.src
  document.querySelector('.js-series-title').textContent = seriesTitle
  document.querySelector('.js-series-description').textContent = seriesDescription
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
