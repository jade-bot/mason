Entity = require './entity'

module.exports = class TableView extends Entity
  constructor: (args = {}) ->
    @collection = args.collection