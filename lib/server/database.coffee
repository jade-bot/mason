{SparseVolume, terraform, Collection, Database, User} = require '../../mason'

persist = require '../persist'

module.exports = ({io}) ->
  db = new Database
  persist.server.database db, io
  
  db.volume = volume = new SparseVolume
  terraform [0, 0, 0], [32, 32, 32], volume
  (require './grass') volume
  
  db.users = db.collections.new key: 'users', model: User
  
  return db