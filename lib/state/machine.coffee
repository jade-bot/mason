Entity = require '../entity'

Stack = require '../stack'

class Machine extends Entity
  constructor: (args = {}) ->
    super
    
    @stack ?= args.stack or new Stack
    @stack.on 'push', => @emit 'statepush', arguments...
    @stack.on 'pop', => @emit 'statepop', arguments...
    @stack.on 'swap', => @emit 'stateswap', arguments...
    
    @on 'statepush', => @emit 'statechange', arguments...
    @on 'statepop', => @emit 'statechange', arguments...
    @on 'stateswap', => @emit 'statechange', arguments...
    
    @on 'statepush', (state) =>
      # console.log 'entering', state.key
      state.enter?()
    
    @states ?= args.states or {}
    
    @transitions ?= args.transitions or {}
    
    Object.defineProperty this, 'state',
      get: => @stack.peek()
  
  can: (key) ->
  
  is: ->
  
  isnt: ->
  
  do: (key) ->
  
  undo: ->
  
  redo: ->
  
  pushState: (state) ->
    @state?.exit?()
    # if @state? then console.log 'exiting', @state.key
    @stack.push arguments...

  replaceState: -> @stack.swap arguments...