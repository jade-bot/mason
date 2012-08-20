{SparseVolume, terraform, Collection, Database} = require '../../mason'

persist = require '../persist'

module.exports = ->
  db = new Database
  persist.server.database db
  
  db.volume = volume = new SparseVolume
  terraform [0, 0, 0], [32, 32, 32], volume
  (require './grass') volume
  
  db.users = db.collections.new key: 'users'
  
  return db