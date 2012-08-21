{EventEmitter} = require 'events'
uuid = require 'node-uuid'

module.exports = class Entity extends EventEmitter
  constructor: (args = {}) ->
    super
    
    @id ?= args.id or uuid()