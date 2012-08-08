Entity = require './entity'

module.exports = class Material extends Entity
  constructor: (args = {}) ->
    super
    
    @key ?= args.key
    
    @image ?= args.image
    
    @texture ?= args.texture
    
    @shaders ?= args.shaders or {}