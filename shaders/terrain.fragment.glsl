precision highp float;

uniform sampler2D uSampler;

varying vec2 vCoord;
varying vec4 vColor;

void main(void) {
  vec4 color = texture2D(uSampler, vCoord);
  
  if (color.a < 0.1) {
    discard;
  }
  
  gl_FragColor = color * vColor;
}