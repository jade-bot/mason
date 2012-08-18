# ext = @gl.getExtension 'WEBKIT_EXT_texture_filter_anisotropic'
# if ext?
#   max_anisotropy = @gl.getParameter ext.MAX_TEXTURE_MAX_ANISOTROPY_EXT
#   max_anisotropy = Math.min 1, max_anisotropy
#   @gl.texParameterf @gl.TEXTURE_2D, ext.TEXTURE_MAX_ANISOTROPY_EXT, max_anisotropy

module.exports = (gl) ->
  extensions = {}
  
  for key in gl.getSupportedExtensions()
    extensions[key] = gl.getExtension key
  
  return extensions