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
	vec4 result = vec4(0.0);
	if (isVector)
	{
		vec2 scalar = getVectorFromTexture(texture2D(visual_field,coords));
		float mag = scalar.x/10.0;
		result = vec4(1.0,1.0,0.0,1.0) * texture2D( visual_field, v_vTexcoord );
	}
	else
	{
		if (isSigned)
		{
		float scalar = getScalarFromTextureSigned(texture2D(visual_field,coords));
		float mag = scalar/10.0;
		result = vec4(0.0,0.0,1.0,1.0) * texture2D( visual_field, v_vTexcoord );
		}
		else
		{
		
		float scalar = getScalarFromTextureUnsigned(texture2D(visual_field,coords));
		//float mag = scalar/10.0;
		result = vec4(1.0,0.0,0.0,1.0) * texture2D( visual_field, v_vTexcoord );//setScalarToTextureSigned(scalar,mag);		
		}
	}
    gl_FragColor = result;//v_vColour * texture2D( gm_BaseTexture, v_vTexcoord );
}
