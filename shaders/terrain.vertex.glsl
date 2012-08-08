attribute vec3 aPosition;
attribute vec2 aCoord;
attribute vec4 aColor;

uniform mat4 uProjection;
uniform mat4 uView;
uniform mat4 uModel;

uniform vec4 uColor;

varying vec2 vCoord;
varying vec4 vColor;

void main(void) {
  vCoord = aCoord;
  vColor = aColor + uColor;
  // vColor = uColor;

  gl_PointSize = 2.0;
  
  gl_Position = uProjection * uView * uModel * vec4(aPosition, 1.0);
}