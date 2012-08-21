{SparseVolume, User, terraform} = require '../../mason'

module.exports = ({db, io}) ->
  db.volume = volume = new SparseVolume
  terraform [0, 0, 0], [32, 32, 32], volume
  (require './grass') volume
  
  db.collections.new key: 'users', model: User