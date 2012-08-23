Entity = require './entity'
Collection = require './collection'

module.exports = class Database extends Entity
  constructor: (args = {}) ->
    super
    
    @collections = new Entity
    @collections.members = Object.create null
    @collections.new = =>
      collection = new Collection arguments...
      @collections.members[collection.id] = collection
      @collections.emit 'add', collection
      return collection
    @collections.on 'add', (collection) =>
      @[collection.key] = collection
  
  describe: ->
    description = {}
    
    for key, collection of @collections.members
      description[key] = collection.describe()
    
    return description
  
  use: (driver) ->
    driver.used this