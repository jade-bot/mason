Entity = require './entity'

module.exports = class Face extends Entity
  constructor: (args = {}) ->
    super
    
    @vertices ?= args.vertices or []
    
    @normal ?= args.normal or [0, 0, 0]