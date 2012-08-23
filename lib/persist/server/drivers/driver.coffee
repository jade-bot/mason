Entity = require '../../../entity'

module.exports = class Driver extends Entity
  constructor: (args = {}) ->
    super
  
  used: (database) ->
    console.log 'used in datbase: ', database.id
  
  track: (entity) ->
    console.log 'tracking entity', entity