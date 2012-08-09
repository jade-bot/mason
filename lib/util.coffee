module.exports = util = {}

util.spin = (entity) ->
  return setInterval ->
    volume.rotateY 1 / 60
    volume.sync()
  , 1000 / 60