Entity = require '../../entity'

ChunkView = require '../../chunk/view'

module.exports = class SparseVolumeView extends Entity
  constructor: (args = {}) ->
    @simulation = args.simulation
    
    @volume = args.volume
    
    @min = args.min
    @max = args.max
    
    @material = args.material
    
    for key, chunk of @volume.chunks
      console.log 'viewing tracked chunk'
      view = new ChunkView
        chunk: chunk
        volume: @volume
        material: @material
      @simulation.add view
    
    @volume.on 'track', (chunk) =>
      console.log 'viewing new tracked chunk'
      view = new ChunkView
        chunk: chunk
        volume: @volume
        material: @material
      @simulation.add view