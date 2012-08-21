Model = require './model'

Character = require './character'

module.exports = class User extends Model
  @property 'alias'
  @property 'email'
  @property 'secret'
  
  @hasMany Character, as: 'characters'
  
  constructor: (args = {}) ->
    super