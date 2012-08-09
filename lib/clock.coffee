Entity = require './entity'

module.exports = class Clock extends Entity
  constructor: (args = {}) ->
    super
    
    @frequency ?= args.frequency or 60
    
    @state ?= args.state or on
    
    @start() if @state is on
  
  tick: ->
    @ticks++
    @ticksThisSecond++
    
    @emit 'tick', Date.now()
  
  start: ->
    @ticks = 0
    @ticksThisSecond = 0
    
    @timer = setInterval =>
      @tick() unless @state is off
    , Math.floor 1000 / @frequency
    
    @fpsTimer = setInterval =>
      @emit 'fps', @ticksThisSecond
      @ticksThisSecond = 0
    , 1000
  
  stop: ->
    clearInterval @timer
  
  pause: ->
    @state = off
  
  resume: ->
    @state = on
  
  reset: ->