Model = require './model'

module.exports = class Loot extends Model
  @property 'x'
  @property 'y'
  @property 'z'
  
  @property 'index'
  
  constructor: (args = {}) ->
    super