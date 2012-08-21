module.exports = ({keyboard}) ->
  keyboard.on 'press', (event) ->
    if event.key is 'b'
      ($ '.bag').show()