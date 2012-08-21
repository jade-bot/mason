{EventEmitter} = require 'events'
uuid = require 'node-uuid'

module.exports = class Property extends EventEmitter
  constructor: (args = {}) ->
    super
    
    @id ?= args.id or uuid()
    
    @key = args.key
    
    @type = args.type