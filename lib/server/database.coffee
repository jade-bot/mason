{Database, persist} = require '../../mason'

module.exports = ({io}) ->
  db = new Database
  persist.server.database db, io
  return db