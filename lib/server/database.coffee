redis = require 'redis'

module.exports = ->
  db = {}
  db.map = {}
  db.instances = {}
  db.add = (entity) ->
    db.drivers.redis.client.hmset entity.id, entity, (error) ->
      db.map[entity.id] = entity
      db.instances[entity.constructor.name.toLowerCase()] ?= {}
      db.instances[entity.constructor.name.toLowerCase()][entity.id] = entity
  
  db.drivers = {}
  db.drivers.redis = {}
  db.drivers.redis.client = redis.createClient()
  
  for key, user of require '../../users'
    db.add user
    db.users ?= {}
    db.users[user.alias] = user
  
  return db