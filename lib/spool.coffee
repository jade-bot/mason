Collection = require './collection'
Entity = require './entity'
Thread = require './thread'

module.exports = class Spool extends Entity
  constructor: (args = {}) ->
    super
    
    @threads = args.threads or new Collection model: Thread
    
    @url = args.url
    
    @concurrency = args.concurrency or 4
    
    for key in [0...@concurrency]
      thread = @threads.new key: key, url: @url
  
  broadcast: (data) ->
    for key, thread of @threads.members
      thread.send data