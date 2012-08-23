module.exports = ({io, simulation, library, Mesh, SparseVolume, blocks}) ->
  makeChar = ({id, position, rotation}) ->
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
  
  io.on 'play', (char) ->
    makeChar char
  
  io.on 'player', (char) ->
    makeChar char