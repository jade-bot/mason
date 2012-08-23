module.exports = ({io, simulation, Mesh, library, SparseVolume, blocks}) ->
  makeLoot = (x, y, z, voxel) ->
    console.log 'loot', x, y, z
    
    loot = new Mesh
      material: library.materials.terrain
      position: [x + 0.5, y + 0.5, z + 0.5]
      # position:
      # rotation: rotation
    # loot.scale = [0.5, 0.5, 0.5]
    # loot.id = id
    loot.volume = new SparseVolume
    loot.template = require '../voxel/loot'
    loot.push = ->
      loot.reset()
      (require '../voxel/extract') voxel, 0, 0, 0, loot.volume, loot, loot.template
      loot.dirty = yes
    loot.push()
    setInterval =>
      loot.rotateY 0.05
    , 1000 / 60
    # players[id] = loot
    simulation.add loot
  
  io.on 'loot', (x, y, z, type) ->
    makeLoot x, y, z, blocks.map[type]