//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform sampler2D scalar_field;
uniform bool isNegative;

////////////////////////////////////////////////////////////
//Functions for converting a texture to a vector or scalar,/
//given a sign and range.///////////////////////////////////
////////////////////////////////////////////////////////////
#define VECTOR_RANGE 10.0
#define SCALAR_RANGE 10.0
vec2 getVectorFromTexture(vec4 colorValues){
	vec2 newVector = vec2(colorValues.x - 128.0,colorValues.y - 128.0);
	newVector = (newVector/128.0) * VECTOR_RANGE;
	return newVector;
}

vec4 setVectorToTexture(vec2 vector){
	vec2 normalizedVector = ((vector/VECTOR_RANGE) + (128.0))/128.0;
	vec4 newVTexture = vec4(normalizedVector,0.0,0.0);
	return newVTexture;
}

float getScalarFromTextureUnsigned(vec4 colorValues){
	float newScalar = (colorValues.x)/255.0;
	newScalar = (newScalar * SCALAR_RANGE);
	return newScalar;
}

vec4 setScalarToTextureUnsigned(float scalar){
	float normalizedScalar = (scalar/SCALAR_RANGE) * 255.0;
	vec4 newSTexture = vec4(normalizedScalar,0.0,0.0,0.0);
	return newSTexture;
}

float getScalarFromTextureSigned(vec4 colorValues){
	float newScalar = (colorValues.x - 128.0)/128.0;
	newScalar = (newScalar * SCALAR_RANGE);
	return newScalar;
}

vec4 setScalarToTextureSigned(float scalar){
	float normalizedScalar = ((scalar/SCALAR_RANGE) + 128.0)/128.0;
	vec4 newSTexture = vec4(normalizedScalar,0.0,0.0,0.0);
	return newSTexture;
}
////////////////////////////////////////////////////////////

void main()
{
	vec2 coords = gl_FragCoord.xy;
	vec4 red = vec4(255.0,0.0,0.0,0.5);
	vec4 orange = vec4(255.0,128.0,0.0,0.5);
	vec4 yellow = vec4(255.0,255.0,0.0,0.5);
	vec4 green = vec4(128.0,255.0,0.0,0.5);
	vec4 blue = vec4(0.0,255.0,255.0,0.5);
	vec4 purple = vec4(128.0,0.0,255.0,0.5);
	vec4 white = vec4(255.0,255.0,255.0,0.5);
	
	
	float scalar = texture2D(scalar_field,coords).r;//getScalarFromTextureUnsigned(texture2D(scalar_field,coords));
	if (isNegative == true)
	{
		scalar = texture2D(scalar_field,coords).r;
	}
	
	if (scalar > 0.0)
		{gl_FragColor = purple * texture2D( gm_BaseTexture, v_vTexcoord );}// * texture2D( gm_BaseTexture, v_vTexcoord );}
	else
		{gl_FragColor = red * texture2D( gm_BaseTexture, v_vTexcoord );}// * texture2D( gm_BaseTexture, v_vTexcoord );}
}
	
	/*
	if ((scalar < -7.0) && (scalar > -10.0))
		{gl_FragColor = purple;}
	else if ((scalar < -3.0) && (scalar > -7.0))
		{gl_FragColor = blue;}
	else if ((scalar < 0.0) && (scalar > -3.0))
		{gl_FragColor = green;}
	else if ((scalar < 3.0) && (scalar > 0.0))
		{gl_FragColor = yellow;}
	else if ((scalar < 7.0) && (scalar > 3.0))
		{gl_FragColor = orange;}
	else if ((scalar < 10.0) && (scalar > 7.0))
		{gl_FragColor = red;}
	else
		{gl_FragColor = white;}
}
			
	/*
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
*/