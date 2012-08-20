blocks = require '../../blocks'

module.exports = ({Spool, Avatar, Axes, Client, Character, Collection}, resources) ->
  client = new Client resources: resources
  {simulation, library, camera, keyboard, mouse} = client
  
  client.brush = blocks.dirt
  
  camera.dynamic = yes
  
  axes = new Axes material: library.materials.line
  simulation.add axes
  
  (require './database')
    client: client
  
  (require './auth')
    simulation: simulation
    library: library
    camera: camera
    client: client
    keyboard: keyboard
    mouse: mouse