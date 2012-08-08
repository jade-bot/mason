HUD = require './hud'

module.exports = (extensions) ->
  hud = new HUD
  
  hud.dom.appendTo document.body
  
  # dom = $ '<ul>'
  # dom.css
  #   position: 'absolute'
  #   left: 0
  #   top: '-100%'
  #   'z-index': 100
  #   width: '100%'
  #   height: '100%'
  # dom.data 'state', 'closed'
  # dom.data 'toggle', ->
  #   state = dom.data 'state'
  #   transition = (dom.data 'transitions')[state]
  #   do (dom.data 'actions')[transition]
  # dom.data 'transitions',
  #   open: 'closed', closed: 'open'
  # dom.data 'actions',
  #   open: ->
  #     dom.animate top: '0%'
  #   close: ->
  #     dom.animate top: '-100%'
  
  # dom.appendTo document.body
  
  # window.key '`', ->
  #   do (dom.data 'toggle')
  
  # for key, extension of extensions
  #   el = $ '<li>'
  #   el.text key
  #   el.appendTo dom