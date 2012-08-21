module.exports = ({io, db, socket}) ->
  socket.on 'login', ({alias, secret}, callback = ->) ->
    user = db.users.find (user) -> (user.alias is alias or user.email is alias) and user.secret is secret
    
    console.log user
    
    if user?
      console.log 'pack'
      callback null, user.pack()
      
      socket.on 'play', ->
        socket.emit 'pack', db.volume.pack()
    else
      callback 'bad login'