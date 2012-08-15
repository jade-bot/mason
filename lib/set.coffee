Entity = require './entity'

module.exports = class Set extends Entity
  constructor: (args = {}) ->
    super
    
    @members = args.members or Object.create null
  
  hash: (member) ->
    member.id
  
  add: (member) ->
    @members[@hash member] = member
    @emit 'add', member
    return member
  
  remove: (member) ->
    delete @members[@hash member]
    @emit 'remove', member
    return member
  
  has: (key) ->
    @members[key]?
  
  get: (key) ->
    @members[key]
  
  set: (key, member) ->
    @members[key] = member
    @emit 'set', member
    return member
  
  random: ->
    keys = Object.keys @members
    index = Math.floor (Math.random() * keys.length)
    key = keys[index]
    return @get key