fs = require 'fs'

obj = fs.readFileSync './models/avatar.obj', 'utf8'

vertices = []
normals = []
faces = []

data = []

for line in obj.split '\n'
  # console.log line
  
  if line[0] is 'v'
    if line[1] is ' '
      [front, a, b, c] = line.split ' '
      vertices.push [(parseFloat a), (parseFloat b), (parseFloat c)]
    
    else if line[1] is 'n'
      [front, a, b, c] = line.split ' '
      normals.push (parseFloat a), (parseFloat b), (parseFloat c)
  
  else if line[0] is 'f'
    [front, a, b, c] = line.split ' '
    
    faces.push [(parseFloat a), (parseFloat b), (parseFloat c)]

for face in faces
  [a, b, c] = face
  
  a -= 1
  b -= 1
  c -= 1
  
  data.push vertices[a][0], vertices[a][1], vertices[a][2]
  data.push 0, 0
  data.push 1, 0, 1, 1
  
  data.push vertices[b][0], vertices[b][1], vertices[b][2]
  data.push 0, 0
  data.push 1, 0, 1, 1
  
  data.push vertices[c][0], vertices[c][1], vertices[c][2]
  data.push 0, 0
  data.push 1, 0, 1, 1

# console.log vertices, normals, faces
fs.writeFileSync './models/avatar.coffee', "module.exports = #{JSON.stringify data}"