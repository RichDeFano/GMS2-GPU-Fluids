varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform vec2 rSize;
uniform float rScale;
uniform float timestep;
uniform float dissipation;

uniform sampler2D velocity_field;
uniform sampler2D advected_field;
uniform bool isScalar;
uniform bool isSource;
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
	vec2 pos = rSize * (coords - timestep * rScale * getVectorFromTexture(texture2D(velocity_field, rSize * coords)));
	if (isScalar == false)
	{
		vec2 color = dissipation * getVectorFromTexture(texture2D(advected_field, pos));
		gl_FragColor = setVectorToTexture(color);// * texture2D( gm_BaseTexture, coords );	
	}
	else{
		float color = dissipation * getScalarFromTextureUnsigned(texture2D(advected_field, pos));
		gl_FragColor = setScalarToTextureUnsigned(color);// * texture2D( gm_BaseTexture, coords );

	}

}
/*
vec4 vectorBilerp(vec2 pos){
	vec2 topL = getVectorFromTexture(texture2D(advected_field, vec2(floor(pos.x),floor(pos.y))));
	vec2  topR = getVectorFromTexture(texture2D(advected_field, vec2(ceil(pos.x),floor(pos.y))));
	vec2  bottomL = getVectorFromTexture(texture2D(advected_field, vec2(floor(pos.x),ceil(pos.y))));
	vec2  bottomR = getVectorFromTexture(texture2D(advected_field, vec2(ceil(pos.x),ceil(pos.y))));
	
	vec2  iTopL = ((ceil(pos.x) - pos.x) / (ceil(pos.x) - floor(pos.x)))*(topL);
	vec2  iTopR = ((pos.x - floor(pos.x)) / (ceil(pos.x) - floor(pos.x)))*(topR);
	
	vec2  firstL = iTopL + iTopR;
	
	vec2  iBottomL = ((ceil(pos.x) - pos.x) / (ceil(pos.x) - floor(pos.x)))*(bottomL);
	vec2  iBottomR = ((pos.x - floor(pos.x)) / (ceil(pos.x) - floor(pos.x)))*(bottomR);
	
	vec2  secondL = iBottomL + iBottomR;
	
	vec2  finalL = ((ceil(pos.y) - pos.y) / (ceil(pos.y) - floor(pos.y)))*(firstL);
	vec2  finalR = ((pos.y - floor(pos.y)) / (ceil(pos.y) - floor(pos.y)))*(secondL);
	
	vec2  bilerp = finalL + finalR;
	vec4 newVec = setVectorToTexture(bilerp);	
	return newVec;
}

vec4 scalarBilerp(vec2 pos){
	float topL = getScalarFromTextureUnsigned(texture2D(advected_field, vec2(floor(pos.x),floor(pos.y))));
	float topR = getScalarFromTextureUnsigned(texture2D(advected_field, vec2(ceil(pos.x),floor(pos.y))));
	float bottomL = getScalarFromTextureUnsigned(texture2D(advected_field, vec2(floor(pos.x),ceil(pos.y))));
	float bottomR = getScalarFromTextureUnsigned(texture2D(advected_field, vec2(ceil(pos.x),ceil(pos.y))));
	
	float iTopL = ((ceil(pos.x) - pos.x) / (ceil(pos.x) - floor(pos.x)))*(topL);
	float iTopR = ((pos.x - floor(pos.x)) / (ceil(pos.x) - floor(pos.x)))*(topR);
	
	float firstL = iTopL + iTopR;
	
	float iBottomL = ((ceil(pos.x) - pos.x) / (ceil(pos.x) - floor(pos.x)))*(bottomL);
	float iBottomR = ((pos.x - floor(pos.x)) / (ceil(pos.x) - floor(pos.x)))*(bottomR);
	
	float secondL = iBottomL + iBottomR;
	
	float finalL = ((ceil(pos.y) - pos.y) / (ceil(pos.y) - floor(pos.y)))*(firstL);
	float finalR = ((pos.y - floor(pos.y)) / (ceil(pos.y) - floor(pos.y)))*(secondL);
	
	float bilerp = finalL + finalR;
	vec4 newTex = setScalarToTextureUnsigned(bilerp);
	
	return newTex;	
}
*/



	/*
		vec2 coords = gl_FragCoord.xy;
	vec2 pos = rSize * (coords - timestep * rScale * getVectorFromTexture(texture2D(velocity_field, rSize * coords)));
	if (isScalar == false)
	{
		vec4 color = dissipation * vectorBilerp(pos);//getVectorFromTexture(texture2D(advected_field, pos));
		gl_FragColor = color;//setVectorToTexture(color);// * texture2D( gm_BaseTexture, coords );	
	}
	else{
		vec4 color = dissipation * scalarBilerp(pos);//getScalarFromTextureUnsigned(texture2D(advected_field, pos));
		gl_FragColor = color;//setScalarToTextureUnsigned(color);// * texture2D( gm_BaseTexture, coords );

	}
	*/



