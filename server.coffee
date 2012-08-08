browserify = require 'browserify'
express = require 'express'
fileify = require 'fileify'
socket_io = require 'socket.io'

app = express()

app.configure =>
  app.use express.static './public'
  
  bundle = browserify
    entry: './entry.coffee'
    debug: on
    ignore: ['shaders']
    # filter: require 'uglify-js'
    # require: []
  
  bundle.use (fileify 'shaders', "#{__dirname}/shaders")
  
  app.use bundle
  
server = app.listen 1337

io = socket_io.listen server, 'log level': 1

io.sockets.on 'connection', (socket) ->
  console.log 'socket'