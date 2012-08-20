Entity = require './entity'

module.exports = class Character extends Entity
  constructor: (args = {}) ->
    super
    
    @name = args.name
    
    @class = args.class