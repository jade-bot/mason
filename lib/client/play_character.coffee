SparseVolume = require '../volume/sparse/volume'
SparseVolumeView = require '../volume/sparse/view'
Mesh = require '../mesh'

blocks = require '../../blocks'

module.exports = ({client, character}) ->
  {mouse, keyboard, library, simulation, camera} = client
  
  camera.position = [16, 40, 16]
  
  players = {}
  
  client.io.emit 'play',
    id: character.id
    position: [camera.position[0], camera.position[1], camera.position[2]]
    rotation: [camera.rotation[0], camera.rotation[1], camera.rotation[2], camera.rotation[3]]
  
  console.log 'playing'
  
  makeChar = ({id, position, rotation}) ->
    console.log 'player'
    
    player = new Mesh material: library.materials.terrain, position: position, rotation: rotation
    player.id = id
    player.volume = new SparseVolume
    player.push = ->
      player.reset()
      (require '../voxel/extract') blocks.stone, 0, 0, 0, player.volume, player
      player.dirty = yes
    player.push()
    players[id] = player
    simulation.add player
  
  client.io.on 'play', (char) ->
    makeChar char
  
  client.io.on 'player', (char) ->
    makeChar char
  
  client.io.on 'position', ({id, position, rotation}) ->
    if players[id]?
      vec3.set position, players[id].position
      quat4.set rotation, players[id].rotation
  
  setInterval =>
    client.io.emit 'position',
      id: character.id
      position: [camera.position[0], camera.position[1], camera.position[2]]
      rotation: [camera.rotation[0], camera.rotation[1], camera.rotation[2], camera.rotation[3]]
    
  , 1000 / 4
  
  client.io.on 'pack', (pack) ->
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