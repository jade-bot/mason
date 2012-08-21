Model = require './model'

module.exports = class Character extends Model
  @property 'name'
  
  @property 'class'
  
  constructor: (args = {}) ->
    super