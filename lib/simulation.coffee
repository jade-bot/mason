Body = require './body'
Clock = require './clock'
Entity = require './entity'

module.exports = class Simulation extends Entity
  constructor: (args = {}) ->
    super
    
    @entities = []
    
    @origin = new Body
    
    @clock = new Clock
    # @clock.on 'fps', -> console.log arguments...
    @clock.on 'tick', => @emit 'tick'
  
  add: ->
    @entities.push arguments...
  
  remove: (subject) ->
    for item, index in @entities
      if item is subject
        @entities.splice index, 1