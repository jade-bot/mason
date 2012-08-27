Driver = require '../driver'

module.exports = class Memory extends Driver
  constructor: (args = {}) ->
    super
    
    @storage = {}
  
  used: (database) ->
    database.collections.on 'add', (collection) =>
      @trackCollection collection
    super
  
  trackCollection: (collection) ->
    collection.on 'add', (entity) =>
      @store entity
    
    @store collection
  
  lookup: (id) ->
    @storage[id]
  
  store: (entity) ->
    @storage[entity.id] = entity
    
    entity.on 'change', =>
      @storage[entity.id] = entity