//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform float scaleA;
uniform float scaleB;

uniform sampler2D a_field;
uniform sampler2D b_field;

///////////////////////////////////////////////////////////////////////////////////////////
#define FLOAT_16_OFFSET (128.0 / 255.0)
#define VECTOR_RANGE 10.0
#define SCALAR_RANGE 10.0

float unpack_ufloat_16(vec2 data) {return data.x + (data.y / 255.0);}
vec2 pack_ufloat_16(float data) {return vec2(floor(data * 255.0) / 255.0, fract(data * 255.0));}
vec2 unpack_uvec2_16(vec4 data) {return vec2(data.xy + (data.zw / 255.0));}
vec4 pack_uvec2_16(vec2 data) {return vec4(floor(data * 255.0) / 255.0, fract(data * 255.0));}
///////////////////////////////////////////////////////////////////////////////////////////
#define VECTOR_RANGE 10.0
#define SCALAR_RANGE 10.0
vec2 getVectorFromTexture(vec4 colorValues){
	vec2 newVector = vec2(colorValues.x - 128.0,colorValues.y - 128.0);
	newVector = (newVector/128.0) * VECTOR_RANGE;
	return newVector;
}

vec4 setVectorToTexture(vec2 vector){
	vec2 normalizedVector = ((vector/VECTOR_RANGE) * (128.0)) + 128.0;
	vec4 newVTexture = vec4(normalizedVector,0.0,1.0);
	return newVTexture;
}

float getScalarFromTextureUnsigned(vec4 colorValues){
	float newScalar = (colorValues.x)/255.0;
	newScalar = (newScalar * SCALAR_RANGE);
	return newScalar;
}

vec4 setScalarToTextureUnsigned(float scalar){
	float normalizedScalar = (scalar/SCALAR_RANGE) * 255.0;
	vec4 newSTexture = vec4(normalizedScalar,0.0,0.0,1.0);
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



void main()
{

	vec2 coords = vec2(gl_FragCoord.xy);
	vec4 color = ((scaleA * texture2D(a_field, coords))) + (scaleB * texture2D(b_field, coords));
	//float mag  = magnitude(color);
	gl_FragColor = color;// * texture2D( tex_field2, coords);
	
/*
	vec2 coords = vec2(gl_FragCoord.xy);
	vec2 newVector = scaleA * getVectorFromTexture(texture2D(vector_field, coords));
	float mag = sqrt( newVector.x*newVector.x + newVector.y*newVector.y ) + (scaleB * getScalarFromTexture(texture2D(scalar_field,coords)));
	gl_FragColor = setScalarToTexture(mag);// * texture2D( tex_field2, coords);
*/	

}
