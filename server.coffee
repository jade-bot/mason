https = require 'https'
browserify = require 'browserify'
express = require 'express'
fileify = require 'fileify'
fs = require 'fs'
socket_io = require 'socket.io'
uuid = require 'node-uuid'

{SparseVolume, terraform} = require './mason'

blocks = require './blocks'

db = {}

db.volume = volume = new SparseVolume
terraform [0, 0, 0], [32, 32, 32], volume

db.users = require './users'

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

app.get '/tos', (req, res) -> res.send require '.privacyPolicy'
app.get '/privacy', (req, res) -> res.send require '.privacyPolicy'

app.get '/', (req, res) -> res.render 'index', js: ''

app.post '/', (req, res) ->
  [signature, data] = req.body.signed_request.split '.'
  
  data = JSON.parse (new Buffer data, 'base64').toString('ascii')
  if data.user_id
    res.render 'index', js: ''
  else
    res.render 'index', js: """
    function displayUser(user) {
      var userName = document.getElementById('userName');
      var greetingText = document.createTextNode('Greetings, ' + user.name + '.');
      userName.appendChild(greetingText);
    }
    
    var appID = 350767991667577;
    
    if (window.location.hash.length == 0) {
      var path = 'https://www.facebook.com/dialog/oauth?';
      var queryParams = ['client_id=' + appID, 'redirect_uri=' + window.location, 'response_type=token'];
      var query = queryParams.join('&');
      var url = path + query;
      window.open(url);
    } else {
      var accessToken = window.location.hash.substring(1);
      var path = "https://graph.facebook.com/me?";
      var queryParams = [accessToken, 'callback=displayUser'];
      var query = queryParams.join('&');
      var url = path + query;
      
      // use jsonp to call the graph
      var script = document.createElement('script');
      script.src = url;
      document.body.appendChild(script);        
    }
    """

# server = app.listen 443
server = https.createServer(
  key: fs.readFileSync './privatekey.pem', 'utf8'
  cert: fs.readFileSync './certificate.pem', 'utf8'
, app).listen 443

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
  
  socket.on 'chat', (message) ->
    io.sockets.emit 'chat', socket.user.alias, message