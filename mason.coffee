require './lib/math'
require './lib/shim'

module.exports = mason = ->

mason.Keyboard = require './lib/keyboard'
mason.Volume = require './lib/volume'
mason.Camera = require './lib/camera'
mason.Avatar = require './lib/avatar'
mason.Client = require './lib/client'
mason.Renderer = require './lib/renderer'
mason.Cube = require './lib/cube'
mason.Axes = require './lib/axes'
mason.Emitter = require './lib/emitter'
mason.Sphere = require './lib/sphere'