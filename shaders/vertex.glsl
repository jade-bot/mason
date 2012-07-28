attribute vec3 aPosition;
attribute vec3 aNormal;
attribute vec2 aCoord;
attribute vec4 aColor;

uniform mat4 uMVMatrix;
uniform mat4 uPMatrix;
uniform mat3 uNMatrix;

uniform vec3 uAmbientColor;

uniform vec3 uLightingDirection;
uniform vec3 uDirectionalColor;

uniform bool uUseLighting;

varying vec2 vCoord;
varying vec3 vLightWeighting;
varying vec4 vColor;

void main(void) {
  gl_Position = uPMatrix * uMVMatrix * vec4(aPosition, 1.0);
  vCoord = aCoord;
  
  vColor = aColor;
  
  if (!uUseLighting) {
    vLightWeighting = vec3(1.0, 1.0, 1.0);
  } else {
    vec3 transformedNormal = uNMatrix * aNormal;
    float directionalLightWeighting = max(dot(transformedNormal, uLightingDirection), 0.0);
    vLightWeighting = uAmbientColor + uDirectionalColor * directionalLightWeighting;
  }
}