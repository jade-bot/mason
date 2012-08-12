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
      view = new ChunkView
        chunk: chunk
        volume: @volume
        material: @material
      @simulation.add view
    
    debugger
    
    @volume.on 'track', (chunk) =>
      view = new ChunkView
        chunk: chunk
        volume: @volume
        material: @material
      @simulation.add view