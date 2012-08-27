blocks = require '../../blocks'

module.exports = ({client, mouse, keyboard}) ->
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
      client.emit 'tool'
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
    
    client.emit 'tool'
  
  toolmap = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '0']
  for toolkey, index in toolmap then do (toolkey, index) ->
    keyboard.on 'press', (event) ->
      if event.key is toolkey
        tool = tools[index]
        
        client.brush = blocks[tool.data 'key']
        
        ($ '.toolbar a i').removeClass 'active'
        tools[selected].find('i').addClass 'active'
        
        client.emit 'tool'