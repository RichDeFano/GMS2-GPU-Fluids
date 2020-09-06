//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform vec3 bias;
uniform vec2 scale;
uniform float maxVal;

uniform sampler2D vector_field;
/*
vec2 getVelocityFromTexture(vec4 colorValues){
	vec2 newVelocity = vec2(colorValues.xy + ((colorValues.zw)/255.0));
	newVelocity = (newVelocity - (128.0/255.0)) * 5.0;
	return newVelocity;
}

*/
void main() {
    //vec4 col = vec4(bias, 1.0) + vec4(getVelocityFromTexture(texture2D(vector_field, scale * gl_FragCoord.xy)),0.0,0.0);
	vec4 col = vec4(bias, 1.0) + texture2D(vector_field, scale * gl_FragCoord.xy);
	gl_FragColor = col * texture2D( gm_BaseTexture, v_vTexcoord );
}