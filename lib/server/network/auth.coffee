module.exports = ({io, db, socket}) ->
  socket.on 'login', ({alias, secret}, callback) ->
    errors = {}
    
    if (db.users.find (member) -> (member.alias is alias or member.email is alias) and member.secret is secret) then errors.alias = 'bad username, email or password'
    if (db.users.find (member) -> (member.alias is alias or member.email is alias) and member.secret is secret) then errors.email = 'bad username, email or password'
    if (db.users.find (member) -> (member.alias is alias or member.email is alias) and member.secret is secret) then errors.secret = 'bad username, email or password'
    
    unless (Object.keys errors).length is 0
      callback 'bad alias, email or password'
    else
      user = db.users.find (member) -> (member.alias is alias or member.email is alias) and member.secret is secret
      callback? null, user