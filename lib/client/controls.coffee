avatar.translateX -speed if keyboard.keys.map.a
avatar.translateX speed if keyboard.keys.map.d
avatar.translateZ -speed if keyboard.keys.map.w
avatar.translateZ speed if keyboard.keys.map.s

look = null
start = null

near = vec3.create()
far = vec3.create()
ray =
  start: vec3.create()
  end: vec3.create()
  direction: vec3.create()
  length: 0

mouse =
  position: vec3.create()

canvas.addEventListener 'mousedown', (event) ->
    start = event
    
    mouse.position[0] = event.clientX
    mouse.position[1] = event.clientY
    mouse.position[2] = 0
    
    canvas.removeEventListener 'mousemove', look
    
    look = (event) ->
      deltaX = (event.clientX - mouse.position[0]) * 0.01
      deltaY = (event.clientY - mouse.position[1]) * 0.01
      
      avatar.rotateGlobalY -deltaX
      avatar.rotateX -deltaY
      
      mouse.position[0] = event.clientX
      mouse.position[1] = event.clientY
      mouse.position[2] = 0
    
    canvas.addEventListener 'mousemove', look
  
  canvas.addEventListener 'mouseup', (event) ->
    canvas.removeEventListener 'mousemove', look
    
    delta = [(start.clientX - event.clientX), (start.clientY - event.clientY), 0]
    
    if (vec3.length delta) < 0.1
      mouse.position[0] = event.clientX
      mouse.position[1] = event.clientY

      mouse.position[1] = viewport[3] - mouse.position[1]
      
      mouse.position[2] = 0
      vec3.unproject mouse.position, camera.view, camera.projection, viewport, near
      
      mouse.position[2] = 1
      vec3.unproject mouse.position, camera.view, camera.projection, viewport, far
      
      vec3.set near, ray.start
      vec3.set far, ray.end
      vec3.subtract ray.end, ray.start, ray.direction
      ray.length = vec3.length ray.direction
      vec3.normalize ray.direction
      
      vec3.set ray.start, line.points[0]
      vec3.set ray.end, line.points[1]
      line.extract()
      line.upload gl
      
      traverse = require './traverse'
      traverse ray.start, ray.direction, (x, y, z) ->
        # console.log arguments...

        # debugger
        key = "#{x}:#{y}:#{z}"
        voxel = volume.voxels[key]
        
        if voxel?
          # alert voxel.type.key
          delete volume.voxels[voxel.key]
          volume.extract()
          volume.upload gl
        
        return voxel?
  
  canvas.addEventListener 'mousewheel', (event) ->
    delta = event.wheelDeltaY / 100
    
    if delta > 0
      vec3.scale camera.delta, 1.1
    else
      vec3.scale camera.delta, 0.9