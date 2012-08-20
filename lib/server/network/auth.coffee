module.exports = ({io, socket}) ->
  socket.on 'login', ({alias, secret}) ->
    return unless alias in (Object.keys db.users)
    
    console.log alias, secret
    
    user = db.users[alias]
    socket.user = user
    
    db.online.add user
    
    socket.emit 'login', user, online: db.online.id
    
    # can only play once logged in
    socket.on 'play', (characterId) ->
      player =
        characterId: characterId
        socket: socket
        user: socket.user
      
      db.players.add player