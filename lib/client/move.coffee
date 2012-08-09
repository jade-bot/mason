module.exports = ({subject, keyboard}, speed = 0.1) ->
  subject.on 'request:movement', ->
    subject.translateX -speed if keyboard.keys.map.a
    subject.translateX speed if keyboard.keys.map.d
    subject.translateZ -speed if keyboard.keys.map.w
    subject.translateZ speed if keyboard.keys.map.s