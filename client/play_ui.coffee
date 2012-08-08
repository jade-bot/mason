HUD = require './hud'

module.exports = (extensions) ->
  hud = new HUD
  
  hud.dom.appendTo document.body
  
  for key, extension of extensions
    el = $ '<li>'
    el.text key
    el.appendTo hud.dom