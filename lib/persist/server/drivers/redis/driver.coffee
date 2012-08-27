async = require 'async'

Driver = require '../driver'

handle = (callthru = ->) ->
  (error, args...) ->
    if error? then console.log error
    else callthru args...

module.exports = class Redis extends Driver
  constructor: (args = {}) ->
    super
    
    redis = require 'redis'
    @client = redis.createClient()
  
  readEntity: (entity, collection, callback = ->) ->
    @client.hgetall entity.id, handle (map) =>
      entity.unpack map if map?
      do callback
  
  writeEntity: (entity, collection, callback = ->) ->
    @client.hmset entity.id, entity.pack(), handle callback
  
  trackEntity: (entity, collection, callback = ->) ->
    async.series [
      (done) => @readEntity entity, collection, done
      (done) => @writeEntity entity, collection, done
    ], (error) =>
      console.log error if error
      do callback
  
  used: (database) ->
    database.collections.on 'add', (collection) =>
      console.log 'collection added to redis driver', collection
      
      @trackCollection collection
    
    super
  
  trackCollection: (collection) ->
    collection.on 'add', (entity) =>
      @trackEntity entity, collection, =>
        @client.sadd collection.id, entity.id, handle()
    
    @readCollection collection, =>
      @writeCollection collection
  
  trackMemberById: (memberId, collection) ->
    member = collection.create (id: memberId), ->
    # @trackEntity member, collection
    collection.add member
  
  readCollection: (collection, callback = ->) ->
    @client.get collection.key, handle (collectionId) =>
      collection.id = collectionId if collectionId?
      collection.emit 'change'
      
      @client.smembers collection.id, handle (members) =>
        console.log members
        (@trackMemberById member, collection) for member in members
        
        do callback
  
  writeCollection: (collection) ->
    @client.set collection.key, collection.id, handle