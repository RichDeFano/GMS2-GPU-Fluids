
uniform float alpha;
uniform float rBeta;  // reciprocal beta term
//uniform bool isPressure

uniform sampler2D x_field;
uniform sampler2D b_field;

varying vec2 v_vTexcoord;


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
	float mag = sqrt((vel.x*vel.x)+(vel.y*vel.y))/14.5;
	return mag;
}

float gauss(vec2 p, float r) {
    return exp(-dot(p, p) / r);
}

////////////////////////////////////////////////////////////
void main() {
	/*
	vec2 coords = vec2(gl_FragCoord.xy);

    float left = getScalarFromTextureUnsigned(texture2D(scalar_field, coords + vec2(-1, 0)));
    float right = getScalarFromTextureUnsigned(texture2D(scalar_field, coords + vec2(1, 0)));
    float bottom = getScalarFromTextureUnsigned(texture2D(scalar_field, coords + vec2(0, -1)));
    float top = getScalarFromTextureUnsigned(texture2D(scalar_field, coords + vec2(0, 1)));

	float div = getScalarFromTextureUnsigned(texture2D(scalar_field,coords));

    float temp = ((left + right + bottom + top + alpha * div) * rBeta);
	gl_FragColor = setScalarToTextureUnsigned(temp);
	*/
	/*
	vec2 coords = vec2(gl_FragCoord.xy);

    vec4 left = texture2D(x_field, coords + vec2(-1, 0));
    vec4 right = texture2D(x_field, coords + vec2(1, 0));
    vec4 bottom = texture2D(x_field, coords + vec2(0, -1));
    vec4 top = texture2D(x_field, coords + vec2(0, 1));

	vec4 div = texture2D(b_field,coords);

    vec4 temp = ((left + right + bottom + top + alpha * div) * rBeta);
	gl_FragColor = temp;//setScalarToTextureUnsigned(temp);
	*/
}

