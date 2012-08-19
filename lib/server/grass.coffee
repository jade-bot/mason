blocks = require '../../blocks'

module.exports = (volume, callback) ->
  volume.on 'set', (x, y, z, voxel) ->
    return unless voxel is blocks.dirt
    
    console.log 'tracking dirt'
    
    interval = setInterval ->
      if (volume.get x, y, z) is blocks.dirt and Math.random() > 0.5
        volume.set x, y, z, blocks.grass
        callback x, y, z, blocks.grass.index
      clearInterval interval
    , 1000 * 1