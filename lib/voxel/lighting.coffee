shadow = 0.25

light = (neighbors, map, out) ->
  {al, bl, cl, dl} = out
  
  [i, j, k, l, m, n, o, p] = map
  
  if neighbors[i]
    al -= shadow
    bl -= shadow
  if neighbors[j]
    cl -= shadow
    dl -= shadow
  if neighbors[k]
    al -= shadow
    cl -= shadow
  if neighbors[l]
    bl -= shadow
    dl -= shadow
  
  al -= shadow if neighbors[m]
  bl -= shadow if neighbors[n]
  cl -= shadow if neighbors[o]
  dl -= shadow if neighbors[p]
  
  out.al = al
  out.bl = bl
  out.cl = cl
  out.dl = dl

map =
  left: [['-1:-1:0'], ['-1:1:0'], ['-1:0:-1'], ['-1:0:1'], ['-1:-1:-1'], ['-1:-1:1'], ['-1:1:-1'], ['-1:1:1']]
  right: [['1:-1:0'], ['1:1:0'], ['1:0:1'], ['1:0:-1'], ['1:-1:1'], ['1:-1:-1'], ['1:1:1'], ['1:1:-1']]
  top: [['0:1:1'], ['0:1:-1'], ['-1:1:0'], ['1:1:0'], ['-1:1:1'], ['1:1:1'], ['-1:1:-1'], ['1:1:-1']]
  bottom: [['0:-1:1'], ['0:-1:-1'], ['1:-1:0'], ['-1:-1:0'], ['1:-1:1'], ['-1:-1:1'], ['1:-1:-1'], ['-1:-1:-1']]
  front: [['0:-1:1'], ['0:1:1'], ['-1:0:1'], ['1:0:1'], ['-1:-1:1'], ['1:-1:1'], ['-1:1:1'], ['1:1:1']]
  back: [['0:-1:-1'], ['0:1:-1'], ['1:0:-1'], ['-1:0:-1'], ['1:-1:-1'], ['-1:-1:-1'], ['1:1:-1'], ['-1:1:-1']]

module.exports = (face, neighbors, out) ->
  out.al = out.bl = out.cl = out.dl = 1
  
  light neighbors, map[face.key], out