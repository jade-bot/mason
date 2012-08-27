module.exports = intersect = ->

EPSILON = 0.001

intersect.rayAABB = (p, d, a, collision) ->
  {position, distance} = collision
  
  tmin = 0
  tmax = 10000
  
  for i in [0...3]
    if (Math.abs d[i]) < EPSILON
        if (p[i] < a.min[i]) or (p[i] > a.max[i]) then return 0
    else
      ood = 1 / d[i]
      t1 = (a.min[i] - p[i]) * ood
      t2 = (a.max[i] - p[i]) * ood
      
      if t1 > t2 then [t1, t2] = [t2, t1]
      
      if t1 > tmin then tmin = t1
      if t2 > tmax then tmax = t2
      
      if tmin > tmax then return 0
  
  vec3.scale d, tmin, collision.position
  vec3.add collision.position, p, collision.position
  
  collision.distance = tmin
  
  return 1

intersect.pointAABB = (p, b, out) ->
  # debugger
  for i in [0...3]
    out[i] = null
    if p[i] < b.min[i] then out[i] = b.min[i]
    if p[i] > b.max[i] then out[i] = b.max[i]

# # var dot00, dot01, dot02, dot11, dot12, invDenom, u, v;
# pointInFace3 (p, a, b, c) ->
#   v0 = vec3.subtract c, a
#   v1 = vec3.subtract b, a
#   v2 = vec3.subtract p, a
  
#   dot00 = vec3.dot v0, v0
#   dot01 = vec3.dot v0, v1
#   dot02 = vec3.dot v0, v2
#   dot11 = vec3.dot v1, v1
#   dot12 = vec3.dot v1, v2

#   invDenom = 1 / (dot00 * dot11 - dot01 * dot01)
#   u = (dot11 * dot02 - dot01 * dot12) * invDenom
#   v = (dot00 * dot12 - dot01 * dot02) * invDenom

#   return (u >= 0) && (v >= 0) && (u + v < 1)

# intersect.rayFace = (model, ray, face) ->
#   [a, b, c, d] = face.vertices
  
#   pointInFace3 a, b, c

# tempVec3 = vec3.create()

# intersect.rayCube = (model, ray, cube) ->
#   for face in cube.face
#     mat4.multiplyVec3 model, face.normal, tempVec3
    
#     continue if (vec3.dot tempVec3, ray.direction) < EPSILON
    
#     intersection = intersect.rayFace model, ray, face
#     return if intersection?
  
#   return