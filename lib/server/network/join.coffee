User = require '../../user'

mail = require '../mail'

module.exports = ({socket, db, io}) ->
  socket.on 'join', ({alias, email, secret}, callback) ->
    console.log 'join', arguments...
    
    errors = {}
    
    if (db.users.find (user) -> user.alias is alias) then errors.alias = 'alias in use'
    if (db.users.find (user) -> user.email is email) then errors.email = 'email in use'
    
    if secret.length < 6 then errors.secret = 'password must be 6 or more unicode characters'
    
    if alias.length < 4 then errors.alias = 'alias too short'
    
    unless (/(.*)@(.*)/g.exec email)? then errors.email = 'email needs format: user@domain.tld'
    
    if (Object.keys errors).length > 0
      console.log 'errors', errors
      callback errors
    else
      user = db.users.new
        alias: alias
        email: email
        secret: secret
      
      callback null, user