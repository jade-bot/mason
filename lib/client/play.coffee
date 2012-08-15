terraform = require '../volume/terraform'

distribute = require './distribute'

module.exports = ({SparseVolumeView, SparseVolume, Spool, Avatar, Axes, Client}, resources) ->
  client = new Client resources: resources
  {simulation, library, camera, keyboard, mouse} = client
  
  camera.velocity = [0, 0, 0]
  
  gravity = [0, -9.81 / 2000, 0]
  
  camera.position = [16, 40, 16]
  
  simulation.on 'tick', ->
    vec3.add camera.velocity, gravity
    vec3.add camera.position, camera.velocity
    
    camera.emit 'request:movement'
    
    camera.update()
  
  axes = new Axes material: library.materials.line
  simulation.add axes
  
  spool = new Spool url: '/worker.js'
  
  volume = new SparseVolume
  terraform [0, 0, 0], [32, 32, 32], volume
  
  distribute volume, spool
  
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
  
  (require './physics')
    subject: camera
    simulation: simulation
    volume: volume
  
  # extensions = (require './extensions') gl
  # ui = (require './play_ui') extensions