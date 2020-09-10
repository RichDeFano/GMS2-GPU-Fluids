//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform sampler2D vector_field;


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
	vec4 white = vec4(255.0,255.0,255.0,0.1);
	vec2 coords = gl_FragCoord.xy;
	vec2 oldVector = getVectorFromTexture(texture2D(vector_field,coords));
	vec4 tempTex = setVectorToTexture(oldVector);
	vec2 vector = getVectorFromTexture(tempTex);
	
	float magnitude = sqrt((vector.x * vector.x) + (vector.y * vector.y));
	
	if ((magnitude < 0.1) && (magnitude > -0.1))
	{gl_FragColor = texture2D(gm_BaseTexture,v_vTexcoord);}
	else
	{gl_FragColor = (magnitude * white) * texture2D(gm_BaseTexture, v_vTexcoord);}
}
/*
	if ((vector.xy > -0.1) && (vector.xy < 0.1))
	{gl_FragColor = texture2D(gm_BaseTexture,v_vTexcoord);}
	else
	{gl_FragColor = (vector.xy * white) * texture2D(gm_BaseTexture, v_vTexcoord);}
	/*
	vec2 coords = gl_FragCoord.xy;
		vec4 white = vec4(255.0,255.0,255.0,0.1);
		
	vec2 testVel = vec2(2.0,5.0);
	//vec2 oldVel = abs(getScalarFromTextureSigned(texture2D(scalar_field,coords)));//abs(-8.0);
	vec4 tempTex = setVectorToTexture(testVel);
	vec2 velocity =  getVectorFromTexture(tempTex);
	
	float magnitude = sqrt((velocity.x*velocity.x) + (velocity.y*velocity.y));
	
	gl_FragColor = (magnitude * white);// * texture2D(gm_BaseTexture, v_vTexcoord);
}
*/