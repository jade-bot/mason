require 'events-off'

require './lib/math'
require './lib/shim'

if global?
  global.SimplexNoise = require './public/noise'

module.exports = mason = ->

mason.Client = require './lib/client'

mason.Mouse = require './lib/mouse'
mason.Keyboard = require './lib/keyboard'

mason.Camera = require './lib/camera'
mason.Avatar = require './lib/avatar'
mason.Renderer = require './lib/renderer'
mason.Axes = require './lib/axes'
mason.Line = require './lib/line'
mason.Material = require './lib/material'
mason.Mesh =require './lib/mesh'

mason.SparseVolume = require './lib/volume/sparse/volume'
mason.SparseVolumeView = require './lib/volume/sparse/view'
mason.Volume = require './lib/volume'

mason.Spool = require './lib/spool'

mason.User = require './lib/user'
mason.Character = require './lib/character'

mason.terraform = require './lib/volume/terraform'

mason.persist = require './lib/persist'

mason.Entity = require './lib/entity'

mason.Model = require './lib/model'

mason.Set = require './lib/set'
mason.Collection = require './lib/collection'

mason.Database = require './lib/database'

mason.Cube = require './lib/cube'

mason.Loot = require './lib/loot'

mason.Wolf = require './lib/wolf'