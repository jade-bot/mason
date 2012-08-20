Collection = require '../collection'

Entity = require '../entity'

persist = require '../persist'

module.exports = ({simulation, client, keyboard, mouse, camera, library}) ->
  {db} = client
  
  auth = new Entity
  
  auth.login = (credentials, callback) ->
    client.io.emit 'login', credentials, callback
  auth.join = (credentials, callback) ->
    client.io.emit 'join', credentials, callback
  
  auth.ui = (require './auth_ui') auth