Set = require './set'

module.exports = class Collection extends Set
  constructor: (args = {}) ->
    super
    
    @model = args.model
    
    @key ?= args.key if args.key?
    
    @on 'add', => @emit 'change'
  
  new: (args, callback) ->
    args ?= {}
    
    @create args, (model) ->
      @emit 'new', model
      callback model
  
  create: (args, callback) ->
    args ?= {}
    
    model = new @model args
    
    @emit 'create', model
    
    @add model, ->
      callback model
  
  find: (callback) ->
    for key, member of @members
      return member if callback member
    return
  
  describe: ->
    description = {}
    for key in ['id', 'key']
      description[key] = this[key]
    return description