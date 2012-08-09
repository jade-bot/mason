Body = require './body'
Entity = require './entity'

module.exports = class Simulation extends Entity
  constructor: (args = {}) ->
    super
    
    @entities = []
    
    @origin = new Body
    
    setInterval =>
      @emit 'tick'
    , 1000 / 60
  
  add: ->
    @entities.push arguments...