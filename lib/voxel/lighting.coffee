shadow = 0.25

light = (neighbors, map, out) ->
  {al, bl, cl, dl} = out
  
  [i, j, k, l, m, n, o, p] = map
  
  al -= shadow if neighbors[i]
  bl -= shadow if neighbors[i]
  cl -= shadow if neighbors[j]
  dl -= shadow if neighbors[j]
  al -= shadow if neighbors[k]
  cl -= shadow if neighbors[k]
  bl -= shadow if neighbors[l]
  dl -= shadow if neighbors[l]
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