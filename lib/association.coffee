{EventEmitter} = require 'events'
uuid = require 'node-uuid'

Collection = require './collection'

module.exports = class Association extends EventEmitter
  constructor: (args = {}) ->
    super
    
    @id ?= args.id or uuid()
    
    @key ?= args.key
    
    @as ?= args.as or args.value?.constructor.name.toLowerCase()
    
    @type = args.type
    
    @cardinality ?= args.cardinality