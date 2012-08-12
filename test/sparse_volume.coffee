assert = require 'assert'

SparseVolume = require '../lib/volume/sparse/volume'
Voxel = class Voxel
  constructor: (@token) ->

volume = new SparseVolume

describe 'Volume', ->
  describe '#set()', ->
    it 'should store a voxel', ->
      voxel = new Voxel token: 'TEST'
      volume.set 0, 0, 0, voxel
      assert.equal voxel.token, (volume.get 0, 0, 0).token
    
    it 'should chunk', ->
      volume.set 0, 0, 0, {}
      assert.deepEqual (Object.keys volume.chunks), ['0:0:0']