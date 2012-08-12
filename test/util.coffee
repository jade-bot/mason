assert = require 'assert'

support = require '../lib/support'

describe 'support', ->
  describe '#voxelToChunk()', ->
    it 'should map voxels to chunks', ->
      test = (voxel, result) ->
        console.log "support.voxelToChunk(#{JSON.stringify voxel}) is #{JSON.stringify result} ✓"
        chunk = [0, 0, 0]
        support.voxelToChunk voxel, chunk
        assert.deepEqual chunk, result
        # console.log '✓'
  
      test [15, 15, 15], [0, 0, 0]
      
      test [16, 15, 15], [1, 0, 0]
      
      test [0, 1, 0], [0, 0, 0]
      
      test [0, 2, 0], [0, 0, 0]
      
      test [0, 15, 0], [0, 0, 0]
      
      test [0, 16, 0], [0, 1, 0]
      
      test [0, 17, 0], [0, 1, 0]
      
      test [0, 32, 0], [0, 2, 0]
      
      test [0, 64, 0], [0, 4, 0]
      
      test [0, 0, 0], [0, 0, 0]
      
      test [-1, 0, 0], [-1, 0, 0]
      
      test [-16, -16, -16], [-1, -1, -1]
      
      test [-17, -17, -17], [-2, -2, -2]
  
  describe '#voxelToChunkVoxel()', ->
    it 'should map voxels to chunk-relative voxels', ->
      test = (voxel, result) ->
        console.log "support.voxelToChunkVoxel(#{JSON.stringify voxel}) is #{JSON.stringify result} ✓"
        chunkVoxel = [0, 0, 0]
        support.voxelToChunkVoxel voxel, chunkVoxel
        assert.deepEqual chunkVoxel, result
  
      test [1, 0, 0], [1, 0, 0]

      test [15, 0, 0], [15, 0, 0]

      test [16, 0, 0], [0, 0, 0]

      test [17, 0, 0], [1, 0, 0]

      test [-1, 0, 0], [15, 0, 0]

      test [-15, 0, 0], [1, 0, 0]

      test [-16, 0, 0], [0, 0, 0]

      test [-17, 0, 0], [15, 0, 0]



describe 'support', ->
  