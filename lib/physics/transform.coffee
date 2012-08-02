module.exports = class Transform
  constructor: (args = {}) ->
    @basis = mat3.create()
    @rotation = quat4.create [0, 0, 0, 1]