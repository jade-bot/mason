# module.exports = ({subject, camera, viewport, mouse}) ->
#   ray =
#     start: vec3.create()
#     end: vec3.create()
#     direction: vec3.create()
#     length: 0
  
#   subject.on 'action', (event) ->
#     mouse.position[0] = event.clientX
#     mouse.position[1] = event.clientY
    
#     mouse.position[1] = viewport[3] - mouse.position[1]
    
#     mouse.position[2] = 0
#     vec3.unproject mouse.position, camera.view, camera.projection, viewport, ray.start
    
#     mouse.position[2] = 1
#     vec3.unproject mouse.position, camera.view, camera.projection, viewport, ray.end
    
#     vec3.subtract ray.end, ray.start, ray.direction
#     ray.length = vec3.length ray.direction
#     vec3.normalize ray.direction
    
#     traverse = require './traverse'
#     traverse ray.start, ray.direction, (x, y, z) ->
      
#         if voxel?
#           delete volume.voxels[voxel.key]
        
#         return voxel?