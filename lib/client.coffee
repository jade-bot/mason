Entity = require './entity'
Camera = require './camera'
Simulation = require './simulation'
Renderer = require './renderer'
Keyboard = require './keyboard'
Library = require './library'

module.exports = class Client extends Entity
  constructor: (args = {}) ->
    super
    
    @simulation ?= args.simulation or new Simulation
    
    @camera ?= args.camera or new Camera
    
    @keyboard ?= args.keyboard or new Keyboard
    @keyboard.bind document
    
    @library ?= args.library or new Library arguments...
    
    @canvases ?= args.canvases or new Array
    
    @initialize()
  
  initialize: ->
    @canvas = @spawnCanvas()
    
    @renderer = new Renderer canvas: @canvas
    
    @renderer.on 'tick', =>
      @renderer.render @simulation, @camera
  
  spawnCanvas: (width, height) ->
    width ?= window.innerWidth
    height ?= window.innerHeight
    
    canvas = document.createElement 'canvas'
    document.body.appendChild canvas
    
    canvas.classList.add 'canvas'
    
    canvas.setAttribute 'width', width
    canvas.setAttribute 'height', height
    
    canvas.viewport = [0, 0, width, height]
    
    return canvas