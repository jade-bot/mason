persist = entity: require './entity'

module.exports = (collection, driver, database) ->
  collection.on 'add', (member, args) ->
    # driver.publish collection.id, member.id unless args?.silent
    # persist.entity member
  
  database[collection.key] ?= collection
  
  # driver.subscribe collection.id, (args...) ->
  #   [op, memberId] = args
    
  #   if op is 'sadd'
  #     member = collection.new (id: memberId), silent: yes
  
  # trackCollection = (collection) ->
  #   client.hset 'map', collection.id, collection.key
    
  #   collection.on 'add', (member) ->
  #     client.sadd collection.id, member.id
  #     client.publish collection.id, JSON.stringify ['sadd', member.id]
    
  #   client.smembers collection.id, (error, memberIds) ->
  #     for memberId in memberIds
  #       member = collection.new id: memberId
  #       persist.server.entity member, database
  
  # if collection.key?
  #   client.type collection.key, (error, type) ->
  #     console.log error if error
      
  #     if type? and type is 'string'
  #       client.get collection.key, (error, collectionId) ->
  #         collection.id = collectionId
  #         trackCollection collection
  #     else
  #       client.set collection.key, collection.id, (error) ->
  #         trackCollection collection
  # else
  #   client.set collection.key, collection.id, (error) ->
  #     trackCollection collection