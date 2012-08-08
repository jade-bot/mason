precision mediump float;

varying vec2 vCoord;
varying vec3 vLightWeighting;
varying vec4 vColor;

uniform float uAlpha;

uniform sampler2D uSampler;

void main(void) {
  vec4 textureColor = texture2D(uSampler, vec2(vCoord.s, vCoord.t));
  
  if(textureColor.a < 1.0)
    discard;
  
  vec4 color = vec4(textureColor.rgb * vLightWeighting, textureColor.a * uAlpha) + vColor;
  
  const vec4 fogcolor = vec4(0.6, 0.8, 1.0, 1.0);
  const float fogdensity = .00005;
  
  float z = gl_FragCoord.z / gl_FragCoord.w;
  float fog = clamp(exp(-fogdensity * z * z), 0.2, 1.0);
 
  gl_FragColor = mix(fogcolor, color, fog);
}