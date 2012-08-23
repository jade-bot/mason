{Database} = require '../../mason'

persist = (require '../persist/server').drivers

module.exports = ({io}) ->
  db = new Database
  db.use new persist.disk.Driver
  db.use new persist.memory.Driver
  db.use new persist.socketio.Driver io: io
  return db