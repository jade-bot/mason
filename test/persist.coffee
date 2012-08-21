assert = require 'assert'

persist = require '../lib/persist'

Database = require '../lib/persist/database'

db = null
io = null

describe 'persist', ->
  describe 'server', ->
  describe '#database()', ->
    beforeEach (done) ->
      redis = (require 'redis').createClient()
      redis.del 'test', ->
        db = new Database
        io =
          sockets:
            on: ->
            emit: ->
        do done
    
    it 'should persist a database', (done) ->
      db.drivers.on 'add', (driver) ->
        if driver? then do done
        else done 'bad driver'
      
      persist.server.database db, io
    
    it "should persist a database's new collections", (done) ->
      persist.server.database db, io
      
      db.collections.on 'add', (collection) ->
        if collection? then do done
        else done 'bad collection'
      
      db.collections.new key: 'test', mode: class Test
    
    it "should persist a database's current collections", (done) ->
      persist.server.database db, io
      
      db.test = db.collections.new key: 'test', model: class Test
      
      if db.test? then do done
      else done 'bad collection'