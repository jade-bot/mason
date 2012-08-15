module.exports = (volume, spool) ->
  for key, chunk of volume.chunks
    spool.broadcast volume.chunks