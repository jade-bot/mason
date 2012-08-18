module.exports = ({client, keyboard}) ->
  chatFrame = $ '<div>'
  chatFrame.appendTo document.body
  chatFrame.addClass 'chatFrame'
  chatFrame.css
    position: 'absolute'
    left: 0
    bottom: 0
    height: '25%'
    opacity: 0.75
    background: 'rgba(0, 0, 0, 0.25)'
    'z-index': 1000
    color: 'white'
    width: '100%'
    '-webkit-user-select': 'none'
  
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
        chatFrame.css opacity: 0.75
        client.chatting = no
        show = no
      else
        input.show()
        input.focus()
        chatFrame.css opacity: 1
        show = yes
        client.chatting = yes
  
  client.io.on 'chat', (alias, message) ->
    chat.append ($ "<li>#{alias}: #{message}</li>") unless message.length is 0