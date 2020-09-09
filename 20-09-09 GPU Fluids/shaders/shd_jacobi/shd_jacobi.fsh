
uniform float alpha;
uniform float rBeta;  // reciprocal beta term

uniform sampler2D pressure_field;
uniform sampler2D divergence_field;

varying vec2 v_vTexcoord;


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



void main() {
	
	vec2 coords = vec2(gl_FragCoord.xy);

    float left = getScalarFromTextureUnsigned(texture2D(pressure_field, coords + vec2(-1, 0)));
    float right = getScalarFromTextureUnsigned(texture2D(pressure_field, coords + vec2(1, 0)));
    float bottom = getScalarFromTextureUnsigned(texture2D(pressure_field, coords + vec2(0, -1)));
    float top = getScalarFromTextureUnsigned(texture2D(pressure_field, coords + vec2(0, 1)));

	float div = getScalarFromTextureSigned(texture2D(divergence_field,coords));

    float temp = ((left + right + bottom + top + alpha * div) * rBeta);
	gl_FragColor = setScalarToTextureUnsigned(temp);
}

