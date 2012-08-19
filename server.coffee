https = require 'https'
browserify = require 'browserify'
express = require 'express'
fileify = require 'fileify'
fs = require 'fs'
socket_io = require 'socket.io'
uuid = require 'node-uuid'
mail = require './lib/server/mail'

{SparseVolume, terraform, User} = require './mason'

blocks = require './blocks'

db = (require './lib/server/database')()

db.volume = volume = new SparseVolume
terraform [0, 0, 0], [32, 32, 32], volume

(require './lib/server/grass') volume

app = express()

app.configure =>
  app.set 'views', (__dirname + '/views')
  app.set 'view engine', 'jade'
  
  app.use express.favicon()
  app.use express.logger('dev')
  app.use express.bodyParser()
  app.use express.methodOverride()
  
  app.use app.router
  
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

app.get '/', (req, res) -> res.render 'index'

server = app.listen 80

io = socket_io.listen server, 'log level': 1

(require './lib/server/network')
  io: io
  db: db