Entity = require '../../entity'

support = require '../../support'

module.exports = class SparseVolume extends Entity
  constructor: (args = {}) ->
    super
    
    @chunks = {}
    
    @_chunk = [0, 0, 0]
    @_chunkVoxel = [0, 0, 0]
    
    @chunkType = require '../../chunk/array'
    
    @on 'set', (x, y, z, voxel) =>
      support.voxelToChunk x, y, z, @_chunk
      support.voxelToChunkVoxel x, y, z, @_chunkVoxel
      
      [a, b, c] = @_chunk 
      [i, j, k] = @_chunkVoxel
      
      if i is  0 then @chunks[support.chunkKey a - 1, b, c]?.emit 'neighbor'
      if i is 15 then @chunks[support.chunkKey a + 1, b, c]?.emit 'neighbor'
      if j is  0 then @chunks[support.chunkKey a, b - 1, c]?.emit 'neighbor'
      if j is 15 then @chunks[support.chunkKey a, b + 1, c]?.emit 'neighbor'
      if k is  0 then @chunks[support.chunkKey a, b, c - 1]?.emit 'neighbor'
      if k is 15 then @chunks[support.chunkKey a, b, c + 1]?.emit 'neighbor'
    
    @on 'set', => @emit 'change'
    @on 'delete', => @emit 'change'
  
  empty: ->
    @chunks = {}
  
  pack: ->
    out = {}
    for key, chunk of @chunks
      voxels = []
      out[key] = pack =
        key: chunk.key
        pack: voxels
        address: chunk.address
      chunk.pack voxels
    return out
  
  unpack: (pack) ->
    for key, chunkPack of pack
      chunk = new @chunkType
        key: chunkPack.key
        position: chunkPack.position
        size: 16
        address: chunkPack.address
      
      @chunks[chunk.key] = chunk
      
      chunk.unpack chunkPack.pack
  
  trackingVoxel: (x, y, z) ->
    @chunks[support.voxelToChunkKey x, y, z]?
  
  voxelChunk: (x, y, z) ->
    return @chunks[support.voxelToChunkKey x, y, z]
  
  voxelVectorChunk: (vector) ->
    return @chunks[support.voxelVectorToChunkKey vector]
  
  track: (x, y, z) ->
    chunk = new @chunkType
      size: 16
      address: support.voxelToChunk x, y, z
      key: support.voxelToChunkKey x, y, z
    @chunks[chunk.key] = chunk
    @emit 'track', chunk
    return chunk
  
  delete: (x, y, z) ->
    chunk = @voxelChunk x, y, z
    return unless chunk?
    support.voxelToChunkVoxel x, y, z, @_chunk
    chunk.deleteVector @_chunk
    @emit 'delete', x, y, z
  
  set: (x, y, z, voxel) ->
    chunk = @voxelChunk x, y, z
    unless chunk? then chunk = @track x, y, z
    support.voxelToChunkVoxel x, y, z, @_chunk
    chunk.setVector @_chunk, voxel
    @emit 'set', x, y, z, voxel, chunk
  
  setVector: (vector, voxel) ->
    chunk = @voxelVectorChunk vector
    unless chunk? then chunk = @track vector[0], vector[1], vector[2]
    support.voxelVectorToChunkVoxel vector, @_chunk
    chunk.setVector @_chunk, voxel
    @emit 'set', vector[0], vector[1], vector[2], voxel, chunk
  
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