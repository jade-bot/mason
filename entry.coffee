mason = require './'

resources =
  materials: require './materials'
  blocks: require './blocks'
  textures: require './textures'

pages =
  edit: require './lib/client/edit'
  play: require './lib/client/play'

document.addEventListener 'DOMContentLoaded', ->
  page = window.location.hash[1..] or 'play'
  pages[page] mason, resources, page