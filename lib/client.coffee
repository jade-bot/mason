Entity = require './entity'
Camera = require './camera'
Simulation = require './simulation'

module.exports = class Client extends Entity
  constructor: (args = {}) ->
    super
    
    @simulation = new Simulation
    @camera = new Camera position: [10, 10, 10]
    @camera.lookTo [0, 0, 0]
  
  spawnCanvas: (width, height) ->
    canvas = document.createElement 'canvas'
    document.body.appendChild canvas
    
    canvas.classList.add 'canvas'
    
    canvas.setAttribute 'width', width
    canvas.setAttribute 'height', height
    
    return canvas