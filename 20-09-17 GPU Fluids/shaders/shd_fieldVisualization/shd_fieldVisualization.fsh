//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform bool isVector;
uniform bool isSigned;

uniform sampler2D visual_field;

///////////////////////////////////////////////////////////////////////////////////////////
#define VECTOR_RANGE 10.0
#define SCALAR_RANGE 10.0
vec2 getVectorFromTexture(vec4 colorValues){
	vec2 newVector = vec2(colorValues.x - 128.0,colorValues.y - 128.0);
	newVector = (newVector/128.0) * VECTOR_RANGE;
	return newVector;
}

vec4 setVectorToTexture(vec2 vector,float alpha){
	vec2 normalizedVector = ((vector/VECTOR_RANGE) * (128.0)) + 128.0;
	vec4 newVTexture = vec4(normalizedVector,0.0,alpha);
	return newVTexture;
}

float getScalarFromTextureUnsigned(vec4 colorValues){
	float newScalar = (colorValues.x)/255.0;
	newScalar = (newScalar * SCALAR_RANGE);
	return newScalar;
}

vec4 setScalarToTextureUnsigned(float scalar,float alpha){
	float normalizedScalar = (scalar/SCALAR_RANGE) * 255.0;
	vec4 newSTexture = vec4(normalizedScalar,0.0,0.0,alpha);
	return newSTexture;
}

float getScalarFromTextureSigned(vec4 colorValues){
	float newScalar = (colorValues.x - 128.0)/128.0;
	newScalar = (newScalar * SCALAR_RANGE);
	return newScalar;
}

vec4 setScalarToTextureSigned(float scalar, float alpha){
	float normalizedScalar = ((scalar/SCALAR_RANGE) * (128.0)) + 128.0;
	vec4 newSTexture = vec4(normalizedScalar,0.0,0.0,alpha);
	return newSTexture;
}

float magnitudeVector(vec2 vel){
	float mag = sqrt((vel.x*vel.x)+(vel.y*vel.y))/sqrt((VECTOR_RANGE*VECTOR_RANGE)+(VECTOR_RANGE*VECTOR_RANGE));
	//mag = abs(mag);
	return mag;
}

float magnitudeScalar(float scalar){
	float mag = sqrt(pow(scalar,2.0))/sqrt(pow(SCALAR_RANGE,2.0));
	//mag = abs(mag);
	return mag;
}

float gauss(vec2 p, float r) {
    return exp(-dot(p, p) / r);
}

////////////////////////////////////////////////////////////

void main()
{
	vec2 coords = gl_FragCoord.xy;
	/*
	vec2 coords = gl_FragCoord.xy;
	if (isVector)
	{
		vec2 vel = getVectorFromTexture(texture2D(visual_field,coords));
		float mag = magnitudeVector(vel);
		gl_FragColor = setVectorToTexture(vel,mag);
	}
	else
	{
		if (isSigned)
		{
		float signed = getScalarFromTextureSigned(texture2D(visual_field,coords));
		float mag = magnitudeScalar(signed);
		gl_FragColor = setScalarToTextureSigned(signed,mag);	
		}
		else
		{
		*/
		float scalar = getScalarFromTextureUnsigned(texture2D(visual_field,coords));
		float mag = scalar/10.0;
		gl_FragColor = vec4(255.0,255.0,255.0,1.0) * texture2D( gm_BaseTexture, v_vTexcoord );//setScalarToTextureSigned(scalar,mag);		
		//}
	//}
    //gl_FragColor = v_vColour * texture2D( gm_BaseTexture, v_vTexcoord );
}
