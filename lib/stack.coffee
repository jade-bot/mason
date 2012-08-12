Entity = require './entity'

module.exports = class Stack extends Entity
  constructor: (args = {}) ->
    super
    
    @array ?= args.array or new Array
  
  push: ->
    @array.push arguments...
    @emit 'push', arguments...
  
  pop: ->
    @array.pop arguments...
    @emit 'pop', arguments...
    
    unless @array.length > 0
      @emit 'drain'
  
  peek: ->
    return unless @array.length > 0
    @array[@array.length - 1]
  
  swap: (item) ->
    @array[@array.length - 1] = item
    @emit 'swap'