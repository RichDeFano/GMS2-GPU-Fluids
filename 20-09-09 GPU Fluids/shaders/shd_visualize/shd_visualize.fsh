//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform vec3 bias;
uniform vec2 scale;
uniform float maxVal;

uniform float alph;
uniform bool isVector;
uniform bool isNegative;
uniform sampler2D vector_field;



void main() {
	vec4 col = vec4(bias, 1.0) * (texture2D(vector_field, scale * gl_FragCoord.xy) / maxVal);
	gl_FragColor = col * texture2D( gm_BaseTexture, v_vTexcoord );
	/*
	vec2 coords = gl_FragCoord.xy;
	if (isVector){
    vec2 v = getVectorFromTexture(texture2D(vector_field,coords));
	gl_FragColor = setVectorToTexture(v);
	}
	else
	{
		if (isNegative)
		{
		float s = getScalarFromTextureS(texture2D(vector_field,coords));
		gl_FragColor = setScalarToTextureS(s);
		} else {
		float s = getScalarFromTextureU(texture2D(vector_field,coords));
		gl_FragColor = setScalarToTextureU(s);
		}
	}
	*/
}