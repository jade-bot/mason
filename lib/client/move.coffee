module.exports = ({subject, keyboard, mouse, client}, speed = 0.1) ->
  subject.on 'request:movement', ->
    return if client.chatting
    
    delta = if keyboard.shift then speed * 5 else speed
    
    subject.delta[0] = 0 ; subject.delta[1] = 0 ; subject.delta[2] = 0
    
    forward = vec3.create()
    back = vec3.create()
    left = vec3.create()
    right = vec3.create()
    
    quat4.multiplyVec3 subject.rotation, [0, 0, -speed], forward
    quat4.multiplyVec3 subject.rotation, [0, 0, +speed], back
    quat4.multiplyVec3 subject.rotation, [-speed, 0, 0], left
    quat4.multiplyVec3 subject.rotation, [+speed, 0, 0], right
    
    forward[1] = 0
    back[1] = 0
    left[1] = 0
    right[1] = 0
    
    if keyboard.keys.map.w then vec3.add forward, subject.delta, subject.delta
    if keyboard.keys.map.s then vec3.add back, subject.delta, subject.delta
    if keyboard.keys.map.a then vec3.add left, subject.delta, subject.delta
    if keyboard.keys.map.d then vec3.add right, subject.delta, subject.delta
    
    # subject.translateZ -delta if mouse.buttons[1] and mouse.buttons[3]