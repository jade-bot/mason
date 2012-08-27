module.exports = ({subject, keyboard}) ->
  keyboard.on 'press', (event) ->
    if event.key is ' '
      subject.velocity[1] += 200