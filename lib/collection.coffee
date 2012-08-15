Set = require './set'

module.exports = class Collection extends Set
  constructor: (args = {}) ->
    super
    
    @model = args.model
  
  new: (args = {}) ->
    model = @create args
    @emit 'new', model
    return model
  
  create: (args = {}) ->
    model = new @model args
    @add model
    return model