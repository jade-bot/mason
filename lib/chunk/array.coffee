Entity = require '../entity'

support = require '../support'

blocks = require '../../blocks'

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
    
    @on 'set', => @emit 'change'
    @on 'delete', => @emit 'change'
  
  unpack: (pack) ->
    @voxels.length = 0
    
    for voxel, index in pack
      if voxel is 0
        continue
      else
        @voxels[index] = blocks.map[voxel]
  
  pack: (out) ->
    for voxel, index in @voxels
      out[index] = voxel?.index or 0
  
  compress: (out) ->
    index = 0
    
    bucket = [null, 0]
    out.push bucket
    
    return unless @voxels.length > 0
    
    while index < (16 * 16 * 16)
      voxel = @voxels[index]
      
      if voxel?
        if voxel.index isnt bucket[0]
          bucket = [voxel.index, 0]
          out.push bucket
      else
        unless bucket[0] is null
          bucket = [null, 0]
          out.push bucket
      
      bucket[1]++
      
      index++
    
    parts = []
    
    for bucket in out
      parts.push "#{bucket[0]}:#{bucket[1]}"
    
    return parts.join ','
  
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
    @emit 'delete', index, null