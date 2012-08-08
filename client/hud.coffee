{Machine, State, Transition} = require './state'

module.exports = class HUD extends Machine
  constructor: (args = {}) ->
    @states =
      collapsed: new State
        key: 'collapsed'
        enter: => @dom.addClass 'collapsed'
        exit: => @dom.removeClass 'collapsed'
      
      expanded: new State
        key: 'expanded'
        enter: => @dom.addClass 'expanded'
        exit: => @dom.removeClass 'expanded'
    
    super
    
    @dom = $ '<ul>'
    @dom.addClass 'hud'
    
    @pushState @states.collapsed
    
    @key = '`'
    window.key @key, (event) =>
      @toggle()
  
  # expand: -> @state = @states.expanded
  # collapse: -> @state = @states.collapsed
  
  toggle: ->
    return @pushState @states.expanded if @state is @states.collapsed
    return @pushState @states.collapsed if @state is @states.expanded