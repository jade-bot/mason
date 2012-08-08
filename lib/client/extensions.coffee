module.exports = (gl) ->
  extensions = {}
  
  for key in gl.getSupportedExtensions()
    extensions[key] = gl.getExtension key
  
  return extensions