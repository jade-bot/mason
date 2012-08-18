User = require './lib/user'

module.exports = users = {}

users.pyro = new User
  alias: 'pyro'
  email: 'pyro@feisty.io'
  secret: 'secret'
  position: [16, 40, 16]

users.user = new User
  alias: 'user'
  email: 'pyro@feisty.io'
  secret: 'secret'
  position: [16, 40, 16]

users.jason = new User
  alias: 'jason'
  email: 'jason@feisty.io'
  secret: 'secret'
  position: [16, 40, 16]

users.luke = new User
  alias: 'luke'
  email: 'luke@feisty.io'
  secret: 'secret'
  position: [16, 40, 16]

users.ian = new User
  alias: 'ian'
  email: 'ian@feisty.io'
  secret: 'secret'
  position: [16, 40, 16]