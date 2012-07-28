window.requestAnimationFrame = window.webkitRequestAnimationFrame

# getShader = (gl, id) ->
#   # shaderScript = document.getElementById id
#   # return null unless shaderScript
  
#   # str = ""
#   # k = shaderScript.firstChild
#   # while k
#   #   str += k.textContent  if k.nodeType is 3
#   #   k = k.nextSibling
  
#   # shader = undefined
  
#   # if shaderScript.type is "x-shader/x-fragment"
#   #   shader = gl.createShader(gl.FRAGMENT_SHADER)
#   # else if shaderScript.type is "x-shader/x-vertex"
#   #   shader = gl.createShader(gl.VERTEX_SHADER)
#   # else
#   #   return null
  
#   # gl.shaderSource shader, str

#   # gl.compileShader shader
  
#   # unless gl.getShaderParameter(shader, gl.COMPILE_STATUS)
#   #   alert gl.getShaderInfoLog(shader)
#   #   return null
  
#   # shader