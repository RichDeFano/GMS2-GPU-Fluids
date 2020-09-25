//#define FLOAT_16_OFFSET (128.0 / 255.0)

varying vec2 v_vTexcoord;
uniform sampler2D velocity_field;
uniform float rHalfScale;


///////////////////////////////////////////////////////////////////////////////////////////
#define VECTOR_RANGE 10.0
#define SCALAR_RANGE 10.0
vec2 getVectorFromTexture(vec4 colorValues){
	vec2 newVector = vec2(colorValues.x - 128.0,colorValues.y - 128.0);
	newVector = (newVector/128.0) * VECTOR_RANGE;
	return newVector;
}

vec4 setVectorToTexture(vec2 vector, float alpha){
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

float magnitude(vec2 vel){
	float mag = sqrt((vel.x*vel.x)+(vel.y*vel.y))/14.5;
	return mag;
}

float gauss(vec2 p, float r) {
    return exp(-dot(p, p) / r);
}

////////////////////////////////////////////////////////////

void main() {
	vec2 coords = vec2(gl_FragCoord.xy);
    float left = getVectorFromTexture(texture2D(velocity_field, coords - vec2(1.0, 0.0))).x;//.xy;//texelFetchOffset(pressure, coords, 0, ivec2(-1, 0));
    float right = getVectorFromTexture(texture2D(velocity_field, coords + vec2(1.0, 0.0))).x;//.xy;
    float bottom = getVectorFromTexture(texture2D(velocity_field, coords - vec2(0.0, 1.0))).y;//.xy;
    float top = getVectorFromTexture(texture2D(velocity_field, coords + vec2(0.0, 1.0))).y;//.xy;
	
	vec2 current = getVectorFromTexture(texture2D(velocity_field,coords));
	//(128 - 128) + (0 - 0)
	float div = ((right - left) + (top-bottom));
	float magX = current.x / 5.0;
	float magY = current.y / 5.0;
	float average = (magX + magY) / 2.0;
	gl_FragColor = setScalarToTextureSigned(div,1.0*average);

	
}
