Mesh = require './mesh'

support = require './support'

module.exports = class Volume extends Mesh
  constructor: (args = {}) ->
    super
    
    @voxels = {}
  
  index: support.chunkKey
  
  set: (i, j, k, voxel) ->
    key = @index i, j, k
    @voxels[key] = voxel
    @emit 'set', key, voxel
  
  get: (i, j, k) ->
    @voxels[@index i, j, k]
  
  setKey: (key, voxel) ->
    @voxels[key] = voxel
    @emit 'set', key, voxel
  
  indexVector: support.chunkKeyVector
  
  setVector: (vector, voxel) ->
    key = @indexVector vector
    @voxels[key] = voxel
    @emit 'set', key, voxel
  
  getVector: (vector) ->
    @voxels[@indexVector vector]