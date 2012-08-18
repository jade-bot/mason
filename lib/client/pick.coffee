module.exports = ({subject, camera, client, mouse, volume}) ->
  {viewport} = client.canvas
  
  blocks = require '../../blocks'
  
  ray =
    start: vec3.create()
    end: vec3.create()
    direction: vec3.create()
    length: 0
  
  scrub = []
  
  cast = (event, callback) ->
    scrub[0] = event.clientX
    scrub[1] = event.clientY
    
    scrub[1] = viewport[3] - scrub[1]
    
    scrub[2] = 0
    vec3.unproject scrub, camera.view, camera.projection, viewport, ray.start
    
    scrub[2] = 1
    vec3.unproject scrub, camera.view, camera.projection, viewport, ray.end
    
    vec3.subtract ray.end, ray.start, ray.direction
    ray.length = vec3.length ray.direction
    vec3.normalize ray.direction
    
    traverse = require './traverse'
    traverse ray.start, ray.direction, callback
  
  event = {}
  
  setInterval ->
    event.clientX = mouse.position[0]
    event.clientY = mouse.position[1]
    
    cast event, (x, y, z, face) ->
      x = Math.floor x ; y = Math.floor y ; z = Math.floor z
      
      voxel = volume.get x, y, z
      
      return unless voxel?
      
      subject.emit 'point', x + face[0], y + face[1], z + face[2]
  , 1000 / 10
  
  subject.on 'action', (event) ->
    cast event, (x, y, z, face) ->
      x = Math.floor x ; y = Math.floor y ; z = Math.floor z
      
      voxel = volume.get x, y, z
      
      if voxel?
        console.log event.which
        if event.which is 1
          volume.delete x, y, z
          client.io.emit 'delete', x, y, z
        else if event.which is 3
          volume.set x + face[0], y + face[1], z + face[2], client.brush
          client.io.emit 'set', x + face[0], y + face[1], z + face[2], client.brush.index
        
        return voxel
      else
        return
  
  client.io.on 'delete', (x, y, z) ->
    volume.delete x, y, z
  
  client.io.on 'set', (x, y, z, voxel) ->
    volume.set x, y, z, blocks.map[voxel]