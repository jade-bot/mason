module.exports = ({io, socket, db}) ->
  socket.on 'pickup', (x, y, z, index) ->
    for key, loot of db.loots.members
      if loot.x is x and loot.y is y and loot.z is z
        socket.emit 'pickup', x, y, z, loot.index
        db.loots.remove loot