blocks = require '../../blocks'

module.exports = ({client, mouse}) ->
  selected = 0
  tools = {}
  
  toolItems = $ '.toolbar a'
  
  for a, index in ($ '.toolbar a') then do (a) =>
    a = $ a
    tools[index] = a
    a.click (event) =>
      ($ '.toolbar a i').removeClass 'active'
      (a.find 'i').addClass 'active'
      client.brush = blocks[a.data 'key']
      false
  
  mouse.on 'wheel', (event) ->
    console.log 'tool'
    
    delta = event.wheelDeltaY
    
    if delta > 0
      delta = 1
    if delta < 0
      delta = -1
    
    selected += delta
    
    # selected %= toolItems.length
    if selected < 0
      selected = toolItems.length - 1
    if selected is toolItems.length
      selected = 0
    
    client.brush = blocks[tools[selected].data 'key']
    
    ($ '.toolbar a i').removeClass 'active'
    tools[selected].find('i').addClass 'active'