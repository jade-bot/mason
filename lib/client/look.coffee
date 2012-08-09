module.exports = ({subject, mouse}) ->
  look = null
  delta = vec3.create()
  
  mouse.on 'down', (event) ->
    start = event
    
    if look? then mouse.off 'move', look
    
    look = (event) ->
      console.log 'move'
      delta[0] = event.x - start.x
      delta[1] = event.y - start.y
      
      subject.rotateGlobalY -delta[0] * 0.01
      subject.rotateX -delta[1] * 0.01
      subject.sync()
      
      start = event
    
    mouse.on 'move', look
  
#   canvas.addEventListener 'mouseup', (event) ->
#     canvas.removeEventListener 'mousemove', look
    
#     delta = [(start.clientX - event.clientX), (start.clientY - event.clientY), 0]
    
#     if (vec3.length delta) < 0.1
#       
  
#   canvas.addEventListener 'mousewheel', (event) ->
#     delta = event.wheelDeltaY / 100
    
#     if delta > 0
#       vec3.scale camera.delta, 1.1
#     else
#       vec3.scale camera.delta, 0.9