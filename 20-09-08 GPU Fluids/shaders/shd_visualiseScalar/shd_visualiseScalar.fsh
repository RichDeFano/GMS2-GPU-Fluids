//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform sampler2D scalar_field;
uniform bool isNegative;

float getScalarFromTextureUnsigned(vec4 colorValues){
	float newScalar = (colorValues.x)/255.0;
	newScalar = (newScalar * 10.0);
	return newScalar;
}

vec4 setScalarToTextureUnsigned(float scalar,float alph){
	float normalizedScalar = (scalar/10.0) * 255.0;
	vec4 newSTexture = vec4(normalizedScalar,0.0,0.0,1.0);
	return newSTexture;
}

float getScalarFromTextureSigned(vec4 colorValues){
	float newScalar = (colorValues.x - 128.0)/255.0;
	newScalar = (newScalar * 10.0);
	return newScalar;
}

vec4 setScalarToTextureSigned(float scalar,float alph){
	float normalizedScalar = ((scalar/10.0) *255.0) + 128.0;
	vec4 newSTexture = vec4(normalizedScalar,0.0,0.0,1.0);
	return newSTexture;
}

void main()
{
	vec2 coords = gl_FragCoord.xy;
	if (isNegative == false)
	{
		float col = getScalarFromTextureUnsigned(texture2D(scalar_field,coords));	
		float alph = abs(col/10.0);
		gl_FragColor = setScalarToTextureUnsigned(col,alph)  * texture2D( gm_BaseTexture, v_vTexcoord );
	}
	else
	{
		float col = getScalarFromTextureSigned(texture2D(scalar_field,coords));	
		float alph = abs(col/10.0);
		gl_FragColor = setScalarToTextureSigned(col,alph) * texture2D( gm_BaseTexture, v_vTexcoord );
	}
}
