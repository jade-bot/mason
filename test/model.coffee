assert = require 'assert'

Model = require '../lib/model'

describe 'Model', ->
  describe '#constructor()', ->
    it 'should construct', (done) ->
      model = new Model
      
      assert.ok model
      
      do done
    
    it 'should subclass', (done) ->
      class Subclass extends Model
      
      subclassInstance = new Subclass
      
      assert.ok subclassInstance
      
      do done
    
    it 'should seperate subclass properties', (done) ->
      class Foo extends Model
        @property 'a'
        @property 'b'
        @property 'c'
        
        constructor: ->
          super
      
      class Bar extends Model
        @property 'x'
        @property 'y'
        @property 'z'
        
        constructor: ->
          super
      
      foo = new Foo
      
      assert.deepEqual (Object.keys foo.constructor.properties), ['a', 'b', 'c']
      
      bar = new Bar
      
      assert.deepEqual (Object.keys bar.constructor.properties), ['x', 'y', 'z']
      
      do done