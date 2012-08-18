blocks = require '../../blocks'

terraform = require '../volume/terraform'

distribute = require './distribute'

module.exports = ({SparseVolumeView, SparseVolume, Spool, Avatar, Axes, Client, Mesh}, resources) ->
  client = new Client resources: resources
  {simulation, library, camera, keyboard, mouse} = client
  
  client.brush = blocks.dirt
  
  camera.dynamic = yes
  camera.position = [16, 40, 16]
  
  axes = new Axes material: library.materials.line
  simulation.add axes
  
  modal = $ '#login'
  modal.modal 'show'
  
  modal.find('.login-btn').click ->
    modal.modal 'hide'
    client.io.emit 'login',
      alias: (modal.find '.alias').val()
      secret: (modal.find '.secret').val()
  
  client.io.on 'login', (user, pack) ->
    volume = new SparseVolume
    # terraform [0, 0, 0], [32, 32, 32], volume
    
    console.log pack
    
    volume.unpack pack
    
    (require './physics')
      subject: camera
      simulation: simulation
      volume: volume
    
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
      client: client
      volume: volume
      camera: camera
    
    (require './ui')
      mouse: mouse
      client: client
  
  # spool = new Spool url: '/worker.js'
  # distribute volume, spool