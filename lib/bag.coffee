Entity = require './entity'

module.exports = class Bag extends Entity
  constructor: (args = {}) ->
    super
    
    @items = args.items or []
    
    @on 'add', (item) ->
      console.log 'add', item
  
  add: (item) ->
    @items.push item
    @emit 'add', item