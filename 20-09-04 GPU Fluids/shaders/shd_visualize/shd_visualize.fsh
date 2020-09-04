//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform vec3 bias;
uniform vec2 scale;
uniform float maxVal;

uniform sampler2D vector_field;


void main() {
    vec4 col = vec4(bias, 1.0) + (texture2D(vector_field, scale * gl_FragCoord.xy) / maxVal);
	gl_FragColor = col * texture2D( gm_BaseTexture, v_vTexcoord );
}