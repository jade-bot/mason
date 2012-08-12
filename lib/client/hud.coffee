State = require '../state'
Machine = require '../state/machine'
Transition = require '../state/transition'

module.exports = class HUD extends Machine
  constructor: (args = {}) ->
    @states =
      collapsed: new State
        key: 'collapsed'
        enter: => @dom.addClass 'collapsed'
        exit: => @dom.removeClass 'collapsed'
      
      expanded: new State
        key: 'expanded'
        enter: =>
          @dom.addClass 'expanded'
          @emit 'expand'
        exit: => @dom.removeClass 'expanded'

    @on 'expand', =>
      @prompt.focus()
    
    super
    
    @dom = $ '<ul>'
    @dom.addClass 'hud'
    
    @pushState @states.collapsed
    
    @key = '`'
    window.key @key, (event) =>
      @toggle()
      event.preventDefault()
    
    @prompt = $ '<input>'
    @prompt.addClass 'prompt'
    @prompt.appendTo @dom
    
    @prompt.on 'keydown', (event) =>
      event.stopPropagation()

      if event.keyCode is 192
        event.preventDefault()
        do @toggle
      
      if event.keyCode is 13
        val = @prompt.val()
        line = $ '<li>'
        line.text "λ #{val}"
        line.appendTo @log

        line = $ '<li>'
        try
          content = JSON.stringify (CoffeeScript.eval val)
        catch e
          content = JSON.stringify e
        line.text content
        line.appendTo @log
        
        @log.data 'height', (@log.data 'height') + (18 * 2)
        @log.css height: (@log.data 'height')
        @prompt.val ''
    
    @log = $ '<ul>'
    @log.addClass 'log'
    @log.appendTo @dom
    @log.data 'height', 0
  
  toggle: ->
    return @pushState @states.expanded if @state is @states.collapsed
    return @pushState @states.collapsed if @state is @states.expanded