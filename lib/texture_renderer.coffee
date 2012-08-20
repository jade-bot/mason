module.exports = (library) ->
  scrub = document.createElement 'canvas'
  scrub.width = 256
  scrub.height = 256
  document.body.appendChild scrub
  
  ctx = scrub.getContext '2d'
  
  ctx.font = 'normal 32px Arial Unicode MS'
  # ctx.fillStyle = 'rgba(0, 0, 0, 255)'
  # ctx.fillRect 0,0, 512, 512
  # ctx.lineWidth = 5
  # ctx.strokeStyle = 'rgba(0,0,0,255)'
  # ctx.textAlign = 'center'
  # ctx.textBaseline = 'middle'
  
  ctx.save()
  # ctx.clearRect 0, 0, 512, 512
  # ctx.fillStyle = 'rgba(0, 0, 0, 255)'
  # ctx.fillRect 0, 0, 16, 16
  # debugger
  ctx.drawImage materials.terrain.image, 0, 0, 256, 256
  ctx.fillStyle = 'rgba(255, 255, 255, 255)'
  ctx.strokeText "✉", 112, 112
  ctx.fillText "✉", 112, 112
  # set texture
  ctx.restore()
  
  document.body.removeChild scrub
  
  return scrub