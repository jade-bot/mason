Entity = require '../entity'

module.exports = class Driver extends Entity
  constructor: (args = {}) ->
    super
    
    @key = args.key
    
    @client = args.client if args.client?
    @socket = args.socket if args.socket?