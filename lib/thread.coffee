Entity = require './entity'

module.exports = class Thread extends Entity
  constructor: (args = {}) ->
    super
    
    @url = args.url
    
    @worker = new Worker @url
    
    @worker.addEventListener 'message', (event) =>
      [channel, message] = event.data
      
      if channel is 'log'
        console.log message
  
  send: (message) ->
    @worker.postMessage message