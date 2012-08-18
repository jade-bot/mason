Entity = require './entity'

module.exports = class User extends Entity
  constructor: (args = {}) ->
    @alias = args.alias
    @position = args.position
    @email = args.email
    @secret = args.secret