terraform = require '../volume/terraform'

module.exports = ({SparseVolumeView, SparseVolume, Avatar, Client}, resources) ->
  client = new Client resources: resources
  {simulation, library, camera, keyboard, mouse} = client
  
  camera.velocity = [0, 0, 0]
  
  gravity = [0, -9.81 * (1 / 240), 0]
  
  simulation.on 'tick', ->
    camera.emit 'request:movement'
    
    # vec3.add camera.velocity, gravity
    # vec3.add camera.position, camera.velocity
    # camera.update()
  
  volume = new SparseVolume
  terraform [0, 0, 0], [16, 128, 16], volume
  
  debugger
  
  volume_view = new SparseVolumeView
    simulation: simulation
    volume: volume
    min: [0, 0, 0]
    max: [16, 128, 16]
    material: library.materials.terrain
  
  (require './controls')
    subject: camera
    keyboard: keyboard
    mouse: mouse
  
  # extensions = (require './extensions') gl
  # ui = (require './play_ui') extensions