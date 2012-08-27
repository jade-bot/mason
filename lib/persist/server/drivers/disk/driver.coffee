fs = require 'fs'
path = require 'path'

mkdirp = require 'mkdirp'

Driver = require '../driver'

module.exports = class Disk extends Driver
  constructor: (args = {}) ->
    super
  
  used: (database) ->
    database.collections.on 'add', (collection) =>
      @trackCollection collection
    
    super
  
  trackCollection: (collection) ->
    console.log 'collection added to disk driver', collection
    
    collection.on 'add', (entity) =>
      @track entity, collection
    
    @readCollection collection
    @writeCollection collection
  
  readCollection: (collection) ->
    # try
    if collection.key?
      collectionId = fs.readFileSync (@collectionKeyPath collection), 'utf8'
      
      console.log collectionId
      
      collection.id = collectionId
    else
      collectionId = collection.id
    
    # console.log collectionId
    
    ids = fs.readdirSync (@collectionIdPath collectionId)
    console.log 'ids', ids
    
    for id in ids
      pack = fs.readFileSync (@collectionEntityIdPath collection, id), 'utf8'
      pack = JSON.parse pack
      console.log pack
      
      types =
        User: require '../../../../user'
        Character: require '../../../../character'
      
      model = new types[pack.type]
      model.unpack pack
      collection.add model
      
    # catch e
    # console.log e
  
  writeCollection: (collection) ->
    if collection.key?
      fs.writeFileSync (@collectionKeyPath collection), collection.id
  
  collectionKeyPath: (collection) ->
    "/Users/pyro/feisty/ToE/data/#{collection.key}"
  
  collectionIdPath: (id) ->
    "/Users/pyro/feisty/ToE/data/#{id}"
  
  collectionPath: (collection) ->
    "/Users/pyro/feisty/ToE/data/#{collection.id}"
  
  associationPath: (entity, collection) ->
    "/Users/pyro/feisty/ToE/data/#{collection.id}/#{entity.id}"
  
  collectionEntityIdPath: (collection, id) ->
    "/Users/pyro/feisty/ToE/data/#{collection.id}/#{id}"
  
  # path: (entity) ->
  #   "/Users/pyro/feisty/ToE/data/#{entity.id}"
  
  # write: (entity) ->
  #   pack = entity.pack()
    
  #   fs.writeFileSync (@path entity), (JSON.stringify pack)
  
  writeAssociation: (entity, collection) ->
    pack = entity.pack()
    
    mkdirp.sync path.dirname (@associationPath entity, collection)
    
    fs.writeFileSync (@associationPath entity, collection), (JSON.stringify pack)
  
  track: (entity, collection) ->
    for key, association of entity.constructor.associations
      # console.log association
      # console.log association
      # console.log entity[association.as]
      delete entity[association.as].key
      @trackCollection entity[association.as]
    
    @writeAssociation entity, collection
    
    entity.on 'change', ->
      @writeAssociation entity, collection
    
    super