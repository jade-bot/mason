self.log = (message) ->
  self.postMessage ['log', message]

# self.log 'init'

self.addEventListener 'message', (event) ->
  self.log event.data