Entity = require '../entity'

module.exports = class Mouse extends Entity
  constructor: (args = {}) ->
    super
    
    @buttons = {}
    
    @position = vec3.create()
    
    @element = args.element
    
    @bind @element if @element
  
  bind: (element) ->
    element.addEventListener 'mousemove', (event) =>
      @position[0] = event.x
      @position[1] = event.y
      
      @emit 'move', event
    
    element.addEventListener 'mousedown', (event) =>
      @buttons[event.which] = on
      
      @emit 'down', event
    
    element.addEventListener 'mouseup', (event) =>
      @buttons[event.which] = off
      
      @emit 'up', event