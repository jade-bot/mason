require 'events-off'

require './lib/math'
require './lib/shim'

if global?
  global.SimplexNoise = require './public/noise'

module.exports = mason = ->

mason.Keyboard = require './lib/keyboard'
mason.SparseVolume = require './lib/volume/sparse/volume'
mason.SparseVolumeView = require './lib/volume/sparse/view'
mason.Volume = require './lib/volume'
mason.Camera = require './lib/camera'
mason.Avatar = require './lib/avatar'
mason.Client = require './lib/client'
mason.Renderer = require './lib/renderer'
mason.Axes = require './lib/axes'
mason.Emitter = require './lib/emitter'
mason.Sphere = require './lib/sphere'
mason.Entity = require './lib/entity'
mason.Line = require './lib/line'
mason.Material = require './lib/material'
mason.Spool = require './lib/spool'
mason.Axes = require './lib/axes'
mason.Mesh =require './lib/mesh'
mason.User = require './lib/user'

mason.terraform = require './lib/volume/terraform'