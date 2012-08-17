browserify = require 'browserify'
express = require 'express'
fileify = require 'fileify'
socket_io = require 'socket.io'
uuid = require 'node-uuid'

{SparseVolume, terraform} = require './mason'

blocks = require './blocks'

db = {}

db.volume = volume = new SparseVolume
terraform [0, 0, 0], [32, 32, 32], volume

db.users = {}

db.users.pyro =
  id: uuid()
  alias: 'pyro'
  email: 'pyro@feisty.io'
  secret: 'secret'
  position: [16, 40, 16]

db.users.user =
  id: uuid()
  alias: 'user'
  email: 'pyro@feisty.io'
  secret: 'secret'
  position: [16, 40, 16]

app = express()

app.configure =>
  app.use express.static './public'
  
  bundle = browserify
    entry: './entry.coffee'
    mount: '/browserify.js'
    debug: on
    ignore: ['shaders']
    # filter: require 'uglify-js'
    # require: []
  
  bundle.use (fileify 'shaders', "#{__dirname}/shaders")
  
  app.use bundle
  
  app.use browserify
    entry: './worker.coffee'
    mount: '/worker.js'
    debug: on
  
server = app.listen 80

io = socket_io.listen server, 'log level': 1

grass = require './lib/server/grass'
grass volume, (x, y, z, voxel) ->
  io.sockets.emit 'set', x, y, z, voxel

io.sockets.on 'connection', (socket) ->
  console.log 'socket'
  
  socket.on 'login', ({alias, secret}) ->
    return unless alias in (Object.keys db.users) or secret isnt 'secret'
    
    console.log alias, secret
    
    user = db.users[alias]
    
    socket.broadcast.emit 'avatar', user
    socket.emit 'avatar', user, true
    socket.emit 'login', user, volume.pack()
    
    socket.user = user
  
  socket.on 'move', (position) ->
    socket.broadcast.emit 'move', socket.user?.id, position
  
  socket.on 'delete', (x, y, z) ->
    volume.delete x, y, z
    
    socket.broadcast.emit 'delete', x, y, z
  
  socket.on 'set', (x, y, z, voxel) ->
    volume.set x, y, z, blocks.map[voxel]
    
    socket.broadcast.emit 'set', x, y, z, voxel