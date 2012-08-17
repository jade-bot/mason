Entity = require './entity'

module.exports = class Keyboard extends Entity
  constructor: (args = {}) ->
    @fields = ['keyCode', 'which']
    
    @keys = map: {}
    
    for field in @fields
      @keys[field] = {}
    
    @map =
      87: 'w'
      83: 's'
      65: 'a'
      68: 'd'
      32: ' '
    
    @shift = off
  
  bind: (target) ->
    target.addEventListener 'keydown', (event) =>
      @keys.map[@map[event.keyCode]] = Date.now()

      for field in @fields
        @keys[field][event[field]] = Date.now()
      
      @shift = event.shiftKey
    
    target.addEventListener 'keyup', (event) =>
      delete @keys.map[@map[event.keyCode]]
      
      for field in @fields
        delete @keys[field][event[field]]
      
      @shift = event.shiftKey
    
    target.addEventListener 'keypress', (event) =>
      console.log event.keyCode
      event.key = @map[event.keyCode]
      @emit 'press', event