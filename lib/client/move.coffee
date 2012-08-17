module.exports = ({subject, keyboard, mouse, client}, speed = 0.33) ->
  subject.on 'request:movement', ->
    return if client.chatting
    
    delta = if keyboard.shift then speed * 5 else speed
    
    subject.translateX -delta if keyboard.keys.map.a
    subject.translateX delta if keyboard.keys.map.d
    subject.translateZ -delta if keyboard.keys.map.w
    subject.translateZ delta if keyboard.keys.map.s
    
    subject.translateZ -delta if mouse.buttons[1] and mouse.buttons[3]