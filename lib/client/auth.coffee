Collection = require '../collection'

Entity = require '../entity'

User = require '../user'

persist = require '../persist'

module.exports = ({simulation, client, keyboard, mouse, camera, library}) ->
  {db} = client
  
  db.auth = auth = new Entity
  
  auth.client = client
  
  db.users.on 'add', (user) ->
    persist.client.entity user, db.users, {}, db, client.io, ->
  
  auth.join = (credentials, callback = ->) ->
    client.io.emit 'join', credentials, (errors) ->
      if errors? then callback errors
      else
        callback null
        auth.login credentials
  
  auth.login = (credentials, callback = ->) ->
    client.io.emit 'login', credentials, (error, userPack) ->
      if error then callback error
      else
        callback null
        
        user = new User
        user.unpack userPack
        
        auth.auth user
  
  auth.on 'auth', (user) ->
    auth.user = user
    console.log user
    db.users.add user
    (require './select_character') auth
  
  auth.auth = (user) ->
    auth.emit 'auth', user
  
  auth.ui = (require './auth_ui') auth
  
  (require './bag_ui') keyboard: keyboard