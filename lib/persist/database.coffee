Entity = require '../entity'
Collection = require '../collection'
Driver = require './driver'

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
    
    @drivers = new Entity
    @drivers.members = Object.create null
    @drivers.new = =>
      driver = new Driver arguments...
      @drivers.members[driver.id] = driver
      @drivers.emit 'add', driver
      return driver