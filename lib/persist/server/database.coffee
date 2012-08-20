redis = require 'redis'

persist =
  server:
    entity: require './entity'

module.exports = (database) ->
  driver = database.drivers.new
    key: 'redis'
    client: redis.createClient()
  
  trackCollection = (collection) ->
    collection.on 'add', (member) ->
      driver.client.sadd collection.id, member.id
      driver.client.publish collection.id, 'sadd', member.id
    
    driver.client.smembers collection.id, (error, memberIds) ->
      for memberId in memberIds
        member = collection.new id: memberId
        persist.server.entity member, database
  
  database.collections.on 'add', (collection) ->
    if collection.key?
      driver.client.type collection.key, (error, type) ->
        console.log error if error
        
        if type? and type is 'string'
          driver.client.get collection.key, (error, collectionId) ->
            collection.id = collectionId
            trackCollection collection
        else
          driver.client.set collection.key, collection.id
          trackCollection collection
    else
      driver.client.set collection.key, collection.id
      trackCollection collection