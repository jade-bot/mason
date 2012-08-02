Entity = require './entity'

# Physics = require './physics'

module.exports = class Simulation extends Entity
  constructor: (args = {}) ->
    super
    
    @entities = {}
    
    @gravity = -9.81
    
    # @physics = new Physics