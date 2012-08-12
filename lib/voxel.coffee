Entity = require './entity'

module.exports = class Voxel extends Entity
  constructor: (args = {}) ->
    super
    
    @position = args.position
    
    @type = args.type