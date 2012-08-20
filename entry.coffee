mason = require './'

resources = require './resources'

pages =
  # edit: require './lib/client/edit'
  play: require './lib/client/play'

document.addEventListener 'DOMContentLoaded', ->
  page = window.location.hash[1..] or 'play'
  pages[page] mason, resources, page