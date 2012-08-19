Entity = require './entity'

module.exports = class User extends Entity
  constructor: (args = {}) ->
    super
    
    @alias = args.alias or @id
    @position = args.position or [16, 40, 16]
    @email = args.email or 'test@test.test'
    @secret = args.secret or 'secret'