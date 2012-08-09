precision mediump float;

varying vec2 vCoord;
varying vec4 vColor;

void main(void) {
  gl_FragColor = vec4(vCoord.x, 0.0, vCoord.y, 1.0);
}