pack =
  entity: require './entity'

module.exports = (collection) ->
  packet = {}
  
  for key, member of collection.members
    packet[key] = pack.entity member
  
  return packet