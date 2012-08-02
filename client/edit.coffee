{Keyboard, Volume, Camera, Avatar, Client, Renderer, Cube, Axes, Emitter} = mason = require '../mason'

document.addEventListener 'DOMContentLoaded', ->
  client = new Client
  
  cube = new Cube
  client.simulation.entities[cube.id] = cube

  axes = new Axes
  client.simulation.entities[axes.id] = axes
  
  emitter = new Emitter
  client.simulation.entities[emitter.id] = emitter
  
  canvas = client.spawnCanvas window.innerWidth, window.innerHeight
  scrub = client.spawnCanvas 500, 500
  
  renderer = new Renderer canvas: canvas, scrub: scrub
  
  renderer.on 'tick', ->
    renderer.render client.simulation, client.camera
  
  (require './ui') client