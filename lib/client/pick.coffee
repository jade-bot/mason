module.exports = ->
  
# near = vec3.create()
# far = vec3.create()
# ray =
#   start: vec3.create()
#   end: vec3.create()
#   direction: vec3.create()
#   length: 0

# mouse.position[0] = event.clientX
# #       mouse.position[1] = event.clientY

# #       mouse.position[1] = viewport[3] - mouse.position[1]
      
# #       mouse.position[2] = 0
# #       vec3.unproject mouse.position, camera.view, camera.projection, viewport, near
      
# #       mouse.position[2] = 1
# #       vec3.unproject mouse.position, camera.view, camera.projection, viewport, far
      
# #       vec3.set near, ray.start
# #       vec3.set far, ray.end
# #       vec3.subtract ray.end, ray.start, ray.direction
# #       ray.length = vec3.length ray.direction
# #       vec3.normalize ray.direction
      
# #       vec3.set ray.start, line.points[0]
# #       vec3.set ray.end, line.points[1]
# #       line.extract()
# #       line.upload gl
      
# #       traverse = require './traverse'
# #       traverse ray.start, ray.direction, (x, y, z) ->
# #         # console.log arguments...

# #         # debugger
# #         key = "#{x}:#{y}:#{z}"
# #         voxel = volume.voxels[key]
        
# #         if voxel?
# #           # alert voxel.type.key
# #           delete volume.voxels[voxel.key]
# #           volume.extract()
# #           volume.upload gl
        
# #         return voxel?