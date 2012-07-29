module.exports = class Keyboard
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
  
  bind: (target) ->
    target.addEventListener 'keydown', (event) =>
      @keys.map[@map[event.keyCode]] = Date.now()

      for field in @fields
        @keys[field][event[field]] = Date.now()
    
    target.addEventListener 'keyup', (event) =>
      delete @keys.map[@map[event.keyCode]]
      
      for field in @fields
        delete @keys[field][event[field]]