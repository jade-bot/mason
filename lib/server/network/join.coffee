User = require '../../user'

mail = require '../mail'

module.exports = ({socket}) ->
  socket.on 'join', ({alias, email, secret}) ->
    user = new User alias: alias, email: email, secret: secret
    
    if users[user.alias]?
      console.log 'user exists'
      
      socket.emit 'error', 'user exists'
    else
      users[user.alias] = user
      
      mail.join user
      
      socket.emit 'join', user