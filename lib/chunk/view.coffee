Mesh = require '../mesh'

extract = require '../volume/extract'

module.exports = class ChunkView extends Mesh
  constructor: (args = {}) ->
    super
    
    @chunk = args.chunk
    
    @volume = args.volume
    
    @min = @chunk.min
    @max = @chunk.max
    
    extract @min, @max, @volume, this
    
    @chunk.on 'neighbor', =>
      console.log 'neighbor'
      extract @min, @max, @volume, this
      @dirty = yes
    
    @chunk.on 'set', =>
      extract @min, @max, @volume, this
      @dirty = yes