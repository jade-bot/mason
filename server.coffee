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

db.users.jason =
  id: uuid()
  alias: 'jason'
  email: 'jason@feisty.io'
  secret: 'secret'
  position: [16, 40, 16]

db.users.luke =
  id: uuid()
  alias: 'luke'
  email: 'luke@feisty.io'
  secret: 'secret'
  position: [16, 40, 16]

db.users.ian =
  id: uuid()
  alias: 'ian'
  email: 'ian@feisty.io'
  secret: 'secret'
  position: [16, 40, 16]

app = express()

app.configure =>
  app.set 'views', (__dirname + '/views')
  app.set 'view engine', 'jade'
  
  app.use express.favicon()
  app.use express.logger('dev')
  app.use express.bodyParser()
  app.use express.methodOverride()
  
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

app.get '/tos', (req, res) ->
  res.send """
  This Privacy Policy governs the manner in which feisty collects, uses, maintains and discloses information collected from users (each, a "User") of the feisty.io website ("Site"). This privacy policy applies to the Site and all products and services offered by feisty.
  
  Personal identification information

  We may collect personal identification information from Users in a variety of ways, including, but not limited to, when Users visit our site, register on the site, place an order, subscribe to the newsletter, respond to a survey, fill out a form, and in connection with other activities, services, features or resources we make available on our Site. Users may be asked for, as appropriate, name, email address, mailing address, credit card information. Users may, however, visit our Site anonymously. We will collect personal identification information from Users only if they voluntarily submit such information to us. Users can always refuse to supply personally identification information, except that it may prevent them from engaging in certain Site related activities.

  Non-personal identification information

  We may collect non-personal identification information about Users whenever they interact with our Site. Non-personal identification information may include the browser name, the type of computer and technical information about Users means of connection to our Site, such as the operating system and the Internet service providers utilized and other similar information.

  Web browser cookies

  Our Site may use "cookies" to enhance User experience. User's web browser places cookies on their hard drive for record-keeping purposes and sometimes to track information about them. User may choose to set their web browser to refuse cookies, or to alert you when cookies are being sent. If they do so, note that some parts of the Site may not function properly.

  How we use collected information

  feisty may collect and use Users personal information for the following purposes:

  - To improve customer service
    Information you provide helps us respond to your customer service requests and support needs more efficiently.
  - To personalize user experience
    We may use information in the aggregate to understand how our Users as a group use the services and resources provided on our Site.
  - To improve our Site
    We may use feedback you provide to improve our products and services.
  - To process payments
    We may use the information Users provide about themselves when placing an order only to provide service to that order. We do not share this information with outside parties except to the extent necessary to provide the service.
  - To run a promotion, contest, survey or other Site feature
    To send Users information they agreed to receive about topics we think will be of interest to them.
  - To send periodic emails
  We may use the email address to send User information and updates pertaining to their order. It may also be used to respond to their inquiries, questions, and/or other requests. If User decides to opt-in to our mailing list, they will receive emails that may include company news, updates, related product or service information, etc. If at any time the User would like to unsubscribe from receiving future emails, we include detailed unsubscribe instructions at the bottom of each email or User may contact us via our Site.

  How we protect your information

  We adopt appropriate data collection, storage and processing practices and security measures to protect against unauthorized access, alteration, disclosure or destruction of your personal information, username, password, transaction information and data stored on our Site.

  Sharing your personal information

  We do not sell, trade, or rent Users personal identification information to others. We may share generic aggregated demographic information not linked to any personal identification information regarding visitors and users with our business partners, trusted affiliates and advertisers for the purposes outlined above.

  Third party websites

  Users may find advertising or other content on our Site that link to the sites and services of our partners, suppliers, advertisers, sponsors, licensors and other third parties. We do not control the content or links that appear on these sites and are not responsible for the practices employed by websites linked to or from our Site. In addition, these sites or services, including their content and links, may be constantly changing. These sites and services may have their own privacy policies and customer service policies. Browsing and interaction on any other website, including websites which have a link to our Site, is subject to that website's own terms and policies.

  Advertising

  Ads appearing on our site may be delivered to Users by advertising partners, who may set cookies. These cookies allow the ad server to recognize your computer each time they send you an online advertisement to compile non personal identification information about you or others who use your computer. This information allows ad networks to, among other things, deliver targeted advertisements that they believe will be of most interest to you. This privacy policy does not cover the use of cookies by any advertisers.

  Compliance with children's online privacy protection act

  Protecting the privacy of the very young is especially important. For that reason, we never collect or maintain information at our Site from those we actually know are under 13, and no part of our website is structured to attract anyone under 13.

  Changes to this privacy policy

  feisty has the discretion to update this privacy policy at any time. When we do, we will post a notification on the main page of our Site, revise the updated date at the bottom of this page and send you an email. We encourage Users to frequently check this page for any changes to stay informed about how we are helping to protect the personal information we collect. You acknowledge and agree that it is your responsibility to review this privacy policy periodically and become aware of modifications.

  Your acceptance of these terms

  By using this Site, you signify your acceptance of this policy and terms of service. If you do not agree to this policy, please do not use our Site. Your continued use of the Site following the posting of changes to this policy will be deemed your acceptance of those changes.

  Contacting us

  If you have any questions about this Privacy Policy, the practices of this site, or your dealings with this site, please contact us at:
  feisty
  feisty.io

  This document was last updated on August 17, 2012

  Privacy policy created by http://www.generateprivacypolicy.com
  """

app.get '/privacy', (req, res) ->
  res.send """
  This Privacy Policy governs the manner in which feisty collects, uses, maintains and discloses information collected from users (each, a "User") of the feisty.io website ("Site"). This privacy policy applies to the Site and all products and services offered by feisty.

  Personal identification information

  We may collect personal identification information from Users in a variety of ways, including, but not limited to, when Users visit our site, register on the site, place an order, subscribe to the newsletter, respond to a survey, fill out a form, and in connection with other activities, services, features or resources we make available on our Site. Users may be asked for, as appropriate, name, email address, mailing address, credit card information. Users may, however, visit our Site anonymously. We will collect personal identification information from Users only if they voluntarily submit such information to us. Users can always refuse to supply personally identification information, except that it may prevent them from engaging in certain Site related activities.

  Non-personal identification information

  We may collect non-personal identification information about Users whenever they interact with our Site. Non-personal identification information may include the browser name, the type of computer and technical information about Users means of connection to our Site, such as the operating system and the Internet service providers utilized and other similar information.

  Web browser cookies

  Our Site may use "cookies" to enhance User experience. User's web browser places cookies on their hard drive for record-keeping purposes and sometimes to track information about them. User may choose to set their web browser to refuse cookies, or to alert you when cookies are being sent. If they do so, note that some parts of the Site may not function properly.

  How we use collected information

  feisty may collect and use Users personal information for the following purposes:

  - To improve customer service
    Information you provide helps us respond to your customer service requests and support needs more efficiently.
  - To personalize user experience
    We may use information in the aggregate to understand how our Users as a group use the services and resources provided on our Site.
  - To improve our Site
    We may use feedback you provide to improve our products and services.
  - To process payments
    We may use the information Users provide about themselves when placing an order only to provide service to that order. We do not share this information with outside parties except to the extent necessary to provide the service.
  - To run a promotion, contest, survey or other Site feature
    To send Users information they agreed to receive about topics we think will be of interest to them.
  - To send periodic emails
  We may use the email address to send User information and updates pertaining to their order. It may also be used to respond to their inquiries, questions, and/or other requests. If User decides to opt-in to our mailing list, they will receive emails that may include company news, updates, related product or service information, etc. If at any time the User would like to unsubscribe from receiving future emails, we include detailed unsubscribe instructions at the bottom of each email or User may contact us via our Site.

  How we protect your information

  We adopt appropriate data collection, storage and processing practices and security measures to protect against unauthorized access, alteration, disclosure or destruction of your personal information, username, password, transaction information and data stored on our Site.

  Sharing your personal information

  We do not sell, trade, or rent Users personal identification information to others. We may share generic aggregated demographic information not linked to any personal identification information regarding visitors and users with our business partners, trusted affiliates and advertisers for the purposes outlined above.

  Third party websites

  Users may find advertising or other content on our Site that link to the sites and services of our partners, suppliers, advertisers, sponsors, licensors and other third parties. We do not control the content or links that appear on these sites and are not responsible for the practices employed by websites linked to or from our Site. In addition, these sites or services, including their content and links, may be constantly changing. These sites and services may have their own privacy policies and customer service policies. Browsing and interaction on any other website, including websites which have a link to our Site, is subject to that website's own terms and policies.

  Advertising

  Ads appearing on our site may be delivered to Users by advertising partners, who may set cookies. These cookies allow the ad server to recognize your computer each time they send you an online advertisement to compile non personal identification information about you or others who use your computer. This information allows ad networks to, among other things, deliver targeted advertisements that they believe will be of most interest to you. This privacy policy does not cover the use of cookies by any advertisers.

  Compliance with children's online privacy protection act

  Protecting the privacy of the very young is especially important. For that reason, we never collect or maintain information at our Site from those we actually know are under 13, and no part of our website is structured to attract anyone under 13.

  Changes to this privacy policy

  feisty has the discretion to update this privacy policy at any time. When we do, we will post a notification on the main page of our Site, revise the updated date at the bottom of this page and send you an email. We encourage Users to frequently check this page for any changes to stay informed about how we are helping to protect the personal information we collect. You acknowledge and agree that it is your responsibility to review this privacy policy periodically and become aware of modifications.

  Your acceptance of these terms

  By using this Site, you signify your acceptance of this policy and terms of service. If you do not agree to this policy, please do not use our Site. Your continued use of the Site following the posting of changes to this policy will be deemed your acceptance of those changes.

  Contacting us

  If you have any questions about this Privacy Policy, the practices of this site, or your dealings with this site, please contact us at:
  feisty
  feisty.io

  This document was last updated on August 17, 2012

  Privacy policy created by http://www.generateprivacypolicy.com
  """

app.post '/', (req, res) ->
  [signature, data] = req.body.signed_request.split '.'
  
  data = JSON.parse (new Buffer data, 'base64').toString('ascii')
  if data.user_id
    res.render 'index.jade', js: ''
  else
    res.render 'index.jade', js: """
    var oauth_url = 'https://www.facebook.com/dialog/oauth/';
    oauth_url += '?client_id=341506039271113';
    oauth_url += '&redirect_uri=' + encodeURIComponent('http://apps.facebook.com/341506039271113/');
    oauth_url += '&scope='
    window.top.location = oauth_url;
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