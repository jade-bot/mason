module.exports = ({subject, mouse}, tolerance = 0.1) ->
  look = null
  delta = vec3.create()
  
  mouse.on 'down', (event) ->
    start = event
    
    if look? then mouse.off 'move', look
    
    look = (event) ->
      delta[0] = event.x - start.x
      delta[1] = event.y - start.y
      
      subject.rotateGlobalY -delta[0] * 0.01
      subject.rotateX -delta[1] * 0.01
      subject.sync()
      
      start = event
    
    mouse.on 'move', look
    
    mouse.on 'up', (event) ->
      mouse.off 'move', look
      
      delta[0] = event.x - start.x
      delta[1] = event.y - start.y
      
      if (vec3.length delta) < tolerance
        subject.emit 'action', event
    
    mouse.on 'wheel', (event) ->
      delta = event.wheelDeltaY / 100
      
      vec3.scale camera.offset, if delta > 0 then 1.1 else 0.9