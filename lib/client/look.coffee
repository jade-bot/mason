module.exports = ({subject, mouse}, tolerance = 0.001) ->
  look = null
  up = null
  delta = vec3.create()
  
  mouse.on 'down', (event) ->
    return unless event.which is 1
    
    start = event
    initial = event
    
    if look? then mouse.off 'move', look
    
    look = (event) ->
      delta[0] = event.x - start.x
      delta[1] = event.y - start.y
      
      subject.rotateGlobalY -delta[0] * 0.01
      subject.rotateX -delta[1] * 0.01
      subject.sync()
      
      start = event
    
    mouse.on 'move', look
    
    up = (event) ->
      mouse.off 'up', up
      
      return unless event.which is 1
      
      mouse.off 'move', look
      
      delta[0] = event.x - initial.x
      delta[1] = event.y - initial.y
      
      if (vec3.length delta) < tolerance
        subject.emit 'action', event
    
    mouse.on 'up', up
  
  mouse.on 'wheel', (event) ->
    delta = event.wheelDeltaY / 100
    
    vec3.scale camera.offset, if delta > 0 then 1.1 else 0.9