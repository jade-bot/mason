Entity = require '../entity'

support = require '../support'

module.exports = class ArrayChunk extends Entity
  constructor: (args = {}) ->
    super
    
    @key = args.key
    
    @voxels = []
    
    @size = args.size or 16
    
    @address = args.address
    
    @min = [
      @address[0] * @size
      @address[1] * @size
      @address[2] * @size
    ]
    
    @max = [
      @address[0] * @size + @size
      @address[1] * @size + @size
      @address[2] * @size + @size
    ]
  
  set: (x, y, z, voxel) ->
    index = support.voxelIndex x, y, z
    @voxels[index] = voxel
    @emit 'set', index, voxel
  
  get: (x, y, z) ->
    @voxels[support.voxelIndex x, y, z]
  
  setVector: (vector, voxel) ->
    index = support.voxelIndex vector[0], vector[1], vector[2]
    @voxels[index] = voxel
    @emit 'set', index, voxel
  
  getVector: (vector) ->
    @voxels[support.voxelIndex vector[0], vector[1], vector[2]]
  
  deleteVector: (vector) ->
    index = support.voxelIndex vector[0], vector[1], vector[2]
    @voxels[index] = null
    @emit 'set', index, null