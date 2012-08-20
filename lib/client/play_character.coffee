SparseVolume = require '../volume/sparse/volume'
SparseVolumeView = require '../volume/sparse/view'
Mesh = require '../mesh'

module.exports = ({simulation, camera, library, keyboard, client, mouse, pack}) ->
  {character} = client.db
  
  client.io.emit 'play', character.id
  
  client.io.on 'pack', (pack) ->
    volume = new SparseVolume
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
     
    ghost = new Mesh material: library.materials.terrain
    ghost.blend = on
    ghost.volume = new SparseVolume
    ghost.push = ->
      ghost.reset()
      (require '../voxel/extract') client.brush, 0, 0, 0, ghost.volume, ghost
      ghost.dirty = yes
    ghost.push()
    client.on 'tool', -> ghost.push()
    simulation.add ghost
     
    camera.on 'point', (x, y, z) ->
      ghost.position[0] = x ; ghost.position[1] = y ; ghost.position[2] = z
    
    camera.position = [16, 40, 16]