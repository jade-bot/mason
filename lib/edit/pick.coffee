ray =
  start: vec3.create()
  end: vec3.create()
  direction: vec3.create()
  length: 0

Cube = require '../cube'

intersect = require '../intersect'

module.exports = ({camera, client, mouse, simulation}) ->
  {viewport} = client.renderer.canvas
  
  scrub = vec3.create()
  
  cast = (event, callback) ->
    scrub[0] = event.clientX ; scrub[1] = event.clientY
    
    scrub[1] = viewport[3] - scrub[1]
    
    scrub[2] = 0
    vec3.unproject scrub, camera.view, camera.projection, viewport, ray.start
    
    scrub[2] = 1
    vec3.unproject scrub, camera.view, camera.projection, viewport, ray.end
    
    vec3.subtract ray.end, ray.start, ray.direction
    ray.length = vec3.length ray.direction
    vec3.normalize ray.direction
  
  subject = camera
  
  mouse.on 'down', (event) ->
    console.log 'action'
    if event.which is 1
      subject.emit 'action', event
  
  subject.on 'action', (event) ->
    cast event
    
    # debugger
    
    collision =
      distance: null
      position: vec3.create()
    
    for key, entity of simulation.entities
      if entity.constructor is Cube
        if (intersect.rayAABB ray.start, ray.direction, entity.aabb, collision)
          console.log collision
          console.log entity.constructor
        else
          console.log 'no hit'