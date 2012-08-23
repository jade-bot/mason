Entity = require './entity'

module.exports = class Keyboard extends Entity
  constructor: (args = {}) ->
    @fields = ['keyCode', 'which']
    
    @keys = map: {}
    
    @keys[field] = {} for field in @fields
    
    @map =
      32: ' '
      65: 'a'
      98: 'b'
      68: 'd'
      83: 's'
      87: 'w'
    
    @shift = off
  
  bind: (target) ->
    target.addEventListener 'keydown', (event) =>
      @keys.map[@map[event.keyCode]] = Date.now()

      @keys[field][event[field]] = Date.now() for field in @fields
      
      @shift = event.shiftKey
    
    target.addEventListener 'keyup', (event) =>
      delete @keys.map[@map[event.keyCode]]
      
      delete @keys[field][event[field]] for field in @fields
      
      @shift = event.shiftKey
    
    target.addEventListener 'keypress', (event) =>
      event.key = @map[event.keyCode]
      @emit 'press', event