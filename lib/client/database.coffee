Collection = require '../collection'

module.exports = ({client}) ->
  client.db ?= {}
  
  {db} = client
  
  db.characters ?= new Collection
  
  db.players ?= new Collection