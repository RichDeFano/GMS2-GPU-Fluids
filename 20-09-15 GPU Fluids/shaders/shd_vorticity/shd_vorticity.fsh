//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;


uniform vec2 size;
uniform float rHalfScale;

uniform sampler2D velocity_field;

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
    vec2 coords = gl_FragCoord.xy;// / size.xy;
	
	vec2 left = getVectorFromTexture(texture2D(velocity_field, coords - vec2(-1.0, 0.0)));//.xy;//texelFetchOffset(pressure, coords, 0, ivec2(-1, 0));
    vec2 right = getVectorFromTexture(texture2D(velocity_field, coords + vec2(1.0, 0.0)));//.xy;
    vec2 bottom = getVectorFromTexture(texture2D(velocity_field, coords + vec2(0.0, -1.0)));//.xy;
    vec2 top = getVectorFromTexture(texture2D(velocity_field, coords + vec2(0.0, 1.0)));//.xy;
	
	float curl = -2.0;//(rHalfScale * ((bottom.x - top.x) - (right.y-left.y))) ;
	//float curl = rHalfScale * (right - left - top + bottom);
    gl_FragColor = setScalarToTextureSigned(curl);
	
	//vorticity * texture2D( velocity_field, coords ); //* texture2D( advected_field, pos);
}