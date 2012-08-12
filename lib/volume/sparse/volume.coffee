Entity = require '../../entity'

support = require '../../support'

module.exports = class SparseVolume extends Entity
  constructor: (args = {}) ->
    super
    
    @chunks = {}
    
    @_chunk = [0, 0, 0]
    
    @chunkType = require '../../chunk/array'
  
  trackingVoxel: (x, y, z) ->
    @chunks[support.voxelToChunkKey x, y, z]?
  
  voxelChunk: (x, y, z) ->
    return @chunks[support.voxelToChunkKey x, y, z]
  
  track: (x, y, z) ->
    chunk = new @chunkType
      size: 16
      address: support.voxelToChunk x, y, z
      key: support.voxelToChunkKey x, y, z
    @chunks[chunk.key] = chunk
    
    @emit 'track', chunk
    
    return chunk
  
  set: (x, y, z, voxel) ->
    chunk = @voxelChunk x, y, z
    
    unless chunk? then chunk = @track x, y, z
    
    support.voxelToChunkVoxel x, y, z, @_chunk
    chunk.setVector @_chunk, voxel
    
    @emit 'set', x, y, z, voxel, chunk
  
  get: (x, y, z) ->
    chunkKey = support.voxelToChunkKey x, y, z
    chunk = @chunks[chunkKey]
    return unless chunk?
    support.voxelToChunkVoxel x, y, z, @_chunk
    chunk.getVector @_chunk
  
  getVector: (vector) ->
    chunkKey = support.voxelVectorToChunkKey vector
    chunk = @chunks[chunkKey]
    return unless chunk?
    support.voxelVectorToChunkVoxel vector, @_chunk
    chunk.getVector @_chunk