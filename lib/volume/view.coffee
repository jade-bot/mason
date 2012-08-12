Entity = require '../entity'

module.exports = class VolumeView extends Entity
  constructor: (args = {}) ->
    @simulation = args.simulation
    
    @volume = args.volume
    
    @min = args.min
    @max = args.max