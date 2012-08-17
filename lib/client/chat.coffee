module.exports = ({client, keyboard}) ->
  chatFrame = $ '<div>'
  chatFrame.appendTo document.body
  chatFrame.css
    position: 'absolute'
    left: 0
    bottom: 0
    height: '50%'
    background: 'rgba(0, 0, 0, 0.5)'
    'z-index': 1000
    color: 'white'
    width: '100%'
  
  chat = $ '<ul>'
  chat.appendTo chatFrame
  chat.css
    position: 'absolute'
    left: 0
    bottom: 80
    width: '100%'
  
  input = $ '<input>'
  input.appendTo chatFrame
  input.css
    position: 'absolute'
    left: 0
    bottom: 40
    background: 'rgba(0, 0, 0, 0.5)'
    color: 'white'
    display: 'none'
    width: '100%'
  
  show = no
  
  keyboard.on 'press', (event) ->
    event.stopPropagation()
    
    if event.keyCode is 13
      if show
        client.io.emit 'chat', input.val()
        input.val ''
        input.hide()
        show = no
      else
        input.show()
        input.focus()
        show = yes
  
  client.io.on 'chat', (alias, message) ->
    chat.append ($ "<li>#{alias}: #{message}</li>") unless message.length is 0