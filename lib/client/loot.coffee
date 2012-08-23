support = require '../support'

tempVec3 = vec3.create()

module.exports = ({io, simulation, Mesh, library, SparseVolume, blocks, db, client}) ->
  makeLoot = (x, y, z, voxel) ->
    loot = db.loots.new x: x, y: y, z: z, index: voxel.index
    
    loot.mesh = new Mesh
      material: library.materials.terrain
      position: [x + 0.5, y + 0.5, z + 0.5]
    loot.volume = new SparseVolume
    loot.template = require '../voxel/loot'
    loot.push = ->
      loot.mesh.reset()
      (require '../voxel/extract') voxel, 0, 0, 0, loot.volume, loot.mesh, loot.template
      loot.mesh.dirty = yes
    loot.push()
    setInterval =>
      loot.mesh.rotateY 0.05
    , 1000 / 60
    simulation.add loot.mesh
  
  @_chunk = vec3.create()
  
  setInterval =>
    # support.voxelVector client.camera.position, @_chunk
    
    for key, loot of db.loots.members
      @_chunk[0] = loot.x
      @_chunk[1] = loot.y
      @_chunk[2] = loot.z
      
      vec3.subtract @_chunk, client.camera.position, tempVec3
      distance = vec3.length tempVec3
      
      # if @_chunk[0] is loot.x and @_chunk[1] is loot.y and @_chunk[2] is loot.z
      if distance < 3
        io.emit 'pickup', loot.x, loot.y, loot.z, loot.index
  , 1000
  
  io.on 'pickup', (x, y, z, entity) ->
    console.log 'picked up', entity
    
    for key, loot of db.loots.members
      if loot.x is x and loot.y is y and loot.z is z
        db.loots.remove loot
        simulation.remove loot.mesh
    
    client.bag.add blocks.map[loot.index].key
  
  io.on 'loot', (x, y, z, type) ->
    makeLoot x, y, z, blocks.map[type]