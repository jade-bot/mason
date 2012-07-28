module.exports = cube = (a = 1000) ->
  data = []
  
  for i in [0...a]
    data.push
      position: [Math.random(), Math.random(), Math.random()]
      color: [Math.random(), Math.random(), Math.random(), 1.0]
  
  return data