terraform = require '../volume/terraform'

distribute = require './distribute'

module.exports = ({SparseVolumeView, SparseVolume, Spool, Avatar, Axes, Client, Mesh}, resources) ->
  client = new Client resources: resources
  {simulation, library, camera, keyboard, mouse} = client
  
  camera.dynamic = yes
  camera.position = [16, 40, 16]
  
  axes = new Axes material: library.materials.line
  simulation.add axes
  
  mesh = new Mesh
  mesh.data = resources.models.avatar
  mesh.material = library.materials.line
  mesh.count = mesh.data.length / 9
  simulation.add mesh
  
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
    simulation: simulation
  
  (require './physics')
    subject: camera
    simulation: simulation
    volume: volume
  
  # extensions = (require './extensions') gl
  # ui = (require './play_ui') extensions