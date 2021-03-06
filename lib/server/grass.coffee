blocks = require '../../blocks'

module.exports = (volume) ->
  volume.on 'set', (x, y, z, voxel) ->
    return unless voxel is blocks.dirt
    
    console.log 'tracking dirt'
    
    interval = setInterval ->
      if (volume.get x, y, z) is blocks.dirt
        if Math.random() > 0.5
          volume.set x, y, z, blocks.grass
      
      else
        clearInterval interval
    , 1000 * 1