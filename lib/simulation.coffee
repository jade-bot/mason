Body = require './body'
Entity = require './entity'

module.exports = class Simulation extends Entity
  constructor: (args = {}) ->
    super
    
    @entities = []
    
    @origin = new Body
  
  add: ->
    @entities.push arguments...