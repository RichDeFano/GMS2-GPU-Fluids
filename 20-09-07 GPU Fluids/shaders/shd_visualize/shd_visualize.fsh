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

vec2 getVectorFromTexture(vec4 colorValues){
	vec2 newVector = vec2(colorValues.xy + ((colorValues.zw)/255.0));
	newVector = (newVector - (128.0/255.0)) * 10.0;
	return newVector;
}

vec4 setVectorToTexture(vec2 vector){
	vec2 normalizedVector = (vector/10.0) + (128.0/255.0);
	vec4 newVTexture = vec4(normalizedVector,0.0,alph);
	return newVTexture;
}

vec4 setScalarToTextureS(float scalar){
	float normalizedScalar = (scalar/10.0) + (128.0/255.0);
	vec4 newSTexture = vec4(normalizedScalar,0.0,0.0,1.0);
	return newSTexture;
}

vec4 setScalarToTextureU(float scalar){
	float normalizedScalar = (scalar/10.0);
	vec4 newSTexture = vec4(normalizedScalar,0.0,0.0,1.0);
	return newSTexture;
}

float getScalarFromTextureS(vec4 colorValues){
	float newScalar = (colorValues.x) + (colorValues.y / 255.0);
	newScalar = ((newScalar - (128.0/255.0)) * 10.0) ;
	return newScalar;
}

float getScalarFromTextureU(vec4 colorValues){
	float newScalar = (colorValues.x) + (colorValues.y / 255.0);
	newScalar = (newScalar * 10.0);
	return newScalar;
}

void main() {
	vec4 col = vec4(bias, 1.0) + (texture2D(vector_field, scale * gl_FragCoord.xy) / maxVal);
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