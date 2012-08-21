Property = require './property'
Association = require './association'

Entity = require './entity'
Collection = require './collection'

User = require './user'

module.exports = class Model extends Entity
  @property: (key, args = {}) ->
    @properties ?= {}
    
    args.key ?= key
    property = new Property args
    @properties[property.key] = property
  
  @has: (type, args = {}) ->
    @associations ?= {}
    
    args.type = type
    args.cardinality = 1
    association = new Association args
    @associations[association.as] = association
  
  @hasMany: (type, args = {}) ->
    @associations ?= {}
    
    args.type = type
    args.cardinality = Infinity
    args.as ?= type.name.toLowerCase() + 's'
    association = new Association args
    @associations[association.as] = association
  
  constructor: (args = {}) ->
    super
    
    @constructor.property 'id'
    
    for key, value of args when @constructor.properties[key]
      @[key] ?= value
    
    for key, association of @constructor.associations
      @[key] ?= args[key]
      @[key] ?= new Collection key: association.as, model: association.type
  
  pack: ->
    pack = {}
    pack[property.key] = @[property.key] for key, property of @constructor.properties
    pack[association.as] = @[association.as].id for key, association of @constructor.associations
    pack.id = @id
    pack.type = @constructor.name
    return pack
  
  unpack: (pack) ->
    type = pack.type
    delete pack.type
    
    @id = pack.id
    
    @[property.key] = pack[property.key] for key, property of @constructor.properties
    @[association.as].id = pack[association.as] for key, association of @constructor.associations
    
    return