module.exports = (volume, subject) ->
  subject.on 'move', ->
    # subject.cell = 