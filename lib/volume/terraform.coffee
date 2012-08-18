blocks = require '../../blocks'

Voxel = require '../voxel'

noise = new SimplexNoise

module.exports = terraform = (min, max, volume) ->
  console.time 'terraform'
  
  for i in [min[0]...max[0]]
    for j in [min[1]...max[1]]
      for k in [min[2]...max[2]]
        if j < 16
          if (noise.noise3D i / 16, j / 16, k / 16) > 0.25 or (noise.noise3D i / 8, j / 8, k / 8) > 0.25
            if Math.random() > 0.95
              volume.set i, j, k, blocks.diamond
            else if Math.random() > 0.95
              volume.set i, j, k, blocks.iron
            else if Math.random() > 0.95
              volume.set i, j, k, blocks.gold
            else if Math.random() > 0.95
              volume.set i, j, k, blocks.coal
            else
              volume.set i, j, k, blocks.stone
        else
          if j < ((noise.noise2D i / 16, k / 16) * 4 + 30)
            volume.set i, j, k, blocks.dirt
  
  for i in [min[0]...max[0]]
    for k in [min[2]...max[2]]
      highest = 0
      
      for j in [min[1]...max[1]]
        highest = j if volume.get i, j, k
      
      if (volume.get i, highest, k) is blocks.dirt
        volume.set i, highest, k, blocks.grass
  
  console.timeEnd 'terraform'