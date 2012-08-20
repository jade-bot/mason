module.exports = (entity) ->
  packet = {}
  
  for key in ['id', 'key']
    if entity[key]?
      packet[key] = entity[key]
  
  return packet