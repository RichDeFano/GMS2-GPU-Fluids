//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

//uniform vec2 prevPoint;
//uniform float timestep;
uniform vec2 point;
uniform float radius;
uniform vec3 fillColor;

uniform vec2 size;
uniform float scale;

uniform sampler2D scalar_field;

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

vec4 setScalarToTextureSigned(float scalar){
	float normalizedScalar = ((scalar/SCALAR_RANGE) * (128.0)) + 128.0;
	vec4 newSTexture = vec4(normalizedScalar,0.0,0.0,1.0);
	return newSTexture;
}

float magnitude(vec2 vel){
	float mag = sqrt((vel.x*vel.x)+(vel.y*vel.y)) / (sqrt((VECTOR_RANGE*VECTOR_RANGE)+(VECTOR_RANGE*VECTOR_RANGE)));
	return mag;
}

float gauss(vec2 p, float r) {
    return exp(-dot(p, p) / r);
}

////////////////////////////////////////////////////////////


void main() {
	vec2 coords = vec2(gl_FragCoord.xy);
    //float sourceScalar = getScalarFromTextureUnsigned(texture2D(gm_BaseTexture, v_vTexcoord));
	float sourceScalar = getScalarFromTextureUnsigned(texture2D(scalar_field, coords));
	float newScalar = sourceScalar;
	//if (abs(distance(point,coords)) < radius)
	//{
	newScalar = mix(sourceScalar, SCALAR_RANGE,gauss((point-coords),radius));
	//}
	//float mag = clamp(newScalar/SCALAR_RANGE,0.0,1.0);
	gl_FragColor = setScalarToTextureUnsigned(newScalar,1.0);

}	

/*
	vec4 newColor = sourceColor;
	if (abs(distance(point,coords)) < radius)
	{
	newColor = mix(sourceColor, vec4(SCALAR_RANGE,0.0,0.0,1.0),gauss((point-coords),radius));
	}
	//float mag = newColor/SCALAR_RANGE;

	gl_FragColor = newColor;
	*/
