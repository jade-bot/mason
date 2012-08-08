Mesh = require './mesh'

module.exports = class Volume extends Mesh
  constructor: (args = {}) ->
    super
    
    @voxels = {}
  
  index: (i, j, k) ->
    "#{i}:#{j}:#{k}"
  
  set: (i, j, k, voxel) ->
    key = @index i, j, k
    @voxels[key] = voxel
    @emit 'set', key, voxel
  
  get: (i, j, k) ->
    @voxels[@index i, j, k]
  
  setKey: (key, voxel) ->
    @voxels[key] = voxel
    @emit 'set', key, voxel
  
  indexVector: (vector) ->
    "#{vector[0]}:#{vector[1]}:#{vector[2]}"
  
  setVector: (vector, voxel) ->
    key = @indexVector vector
    @voxels[key] = voxel
    @emit 'set', key, voxel
  
  getVector: (vector) ->
    @voxels[@indexVector vector]