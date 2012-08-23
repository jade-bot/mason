# Entity = require '../../entity'

# persist = collection: require './collection'

# User = require '../../user'

Driver = require '../driver'

module.exports = class Memory extends Driver
  constructor: (args = {}) ->
    super
    
    @storage = {}
  
  used: (database) ->
    database.collections.on 'add', (collection) =>
      console.log 'collection added to memory driver', collection
      
      @trackCollection collection
      
      collection.on 'add', (entity) =>
        @track entity, collection
    
    super
  
  trackCollection: (collection) ->
    @storage[collection.id] = collection
  
  track: (entity, collection) ->
    super
    
    # @storage[collection.id].members[]
  
  lookup: (id) ->
    @storage[id]
  
  store: (entity) ->
    @storage[entity.id] = entity
  
  # hmset = (key, map, callback = ->) ->
  #   type = map.type
    
  #   console.log key, map
    
  #   model = driver.lookup key
  #   model ?= new driver.types[type]
  #   model.unpack map
  #   driver.store model
    
  #   do callback
  
  # driver.publish = (channel, args...) ->
  #   driver.map[channel] ?= []
  #   listener channel, args... for listener in driver.map[channel]
  #   return
  
  # driver.subscribe = (channel, callback = ->) ->
  #   driver.map[channel] ?= []
  #   driver.map[channel].push callback
  #   return