module.exports = ->
  {Keyboard, Volume, Camera, Avatar, Client, Renderer, Cube, Axes, Emitter, Entity} = mason = require '../../mason'

  class Demo extends Entity
    constructor: (args = {}) ->
      super
      
      @key = args.key
      
      @main = args.main

      @thumbnail = args.thumbnail

  demos = []

  demos.push new Demo
    key: 'particles'
    main: (client) ->
      emitter = new Emitter
      client.simulation.entities[emitter.id] = emitter

  demos.push new Demo
    key: 'cube'
    main: (client) ->
      cube = new Cube
      client.simulation.entities[cube.id] = cube

  demos.push new Demo
    key: 'physics'
    main: (client) ->
      physics = new Physics
      client.simulation.physics = physics

  # demos.push new Demo
  #   key: 'benchmark'
  #   main: (client) ->
  #     (require './benchmark')()

  document.addEventListener 'DOMContentLoaded', ->
    client = new Client
    
    vec3.set [10, 10, 10], client.camera.position
    client.camera.lookAt client.simulation.origin
    
    (require './ui') client, demos
    
    client.runDemo = (demo) ->
      canvas = client.spawnCanvas window.innerWidth, window.innerHeight
      scrub = client.spawnCanvas 500, 500
      
      renderer = new Renderer canvas: canvas, scrub: scrub
      
      renderer.on 'tick', ->
        renderer.render client.simulation, client.camera
      
      axes = new Axes
      client.simulation.entities[axes.id] = axes
      
      demo.main client