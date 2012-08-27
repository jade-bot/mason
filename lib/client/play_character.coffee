SparseVolume = require '../volume/sparse/volume'
SparseVolumeView = require '../volume/sparse/view'
Mesh = require '../mesh'

Wolf = require '../wolf'

blocks = require '../../blocks'

module.exports = ({client, character}) ->
  {mouse, keyboard, library, simulation, camera, io, db} = client
  
  camera.position = [16, 40, 16]
  
  players = {}
  
  (require './bag')
    client: client
    character: character
    keyboard: keyboard
  
  io.emit 'play',
    id: character.id
    position: [camera.position[0], camera.position[1], camera.position[2]]
    rotation: [camera.rotation[0], camera.rotation[1], camera.rotation[2], camera.rotation[3]]
  
  (require './loot')
    io: io, simulation: simulation, Mesh: Mesh, library: library, SparseVolume: SparseVolume, blocks: blocks, db: db, client: client
  
  (require './avatars')
    io: io, simulation: simulation, Mesh: Mesh, library: library, SparseVolume: SparseVolume, blocks: blocks, db: db, client: client
  
  io.on 'position', ({id, position, rotation}) ->
    if players[id]?
      vec3.set position, players[id].position
      quat4.set rotation, players[id].rotation
  
  wolf = new Wolf position: [0, 40, 0], material: library.materials.wolf
  simulation.add wolf
  
  setInterval =>
    io.emit 'position',
      id: character.id
      position: [camera.position[0], camera.position[1], camera.position[2]]
      rotation: [camera.rotation[0], camera.rotation[1], camera.rotation[2], camera.rotation[3]]
    
  , 1000 / 4
  
  io.on 'pack', (pack) ->
    console.log 'packed'
    
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
      keyboard: keyboard
     
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