Entity = require './entity'

module.exports = class Bag extends Entity
  constructor: (args = {}) ->
    super
    
    @items = args.items or []
  
  add: (item) ->
    @items.push item
    @emit 'add', item