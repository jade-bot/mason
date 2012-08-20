types =
  users: require '../../user'

module.exports = (packets, db) ->
  for key, packet of packets
    packet.model = types[key]
    db.collections.new packet
  return