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

vec4 setScalarToTextureUnsigned(float scalar, float alpha){
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
	float mag = sqrt((vel.x*vel.x)+(vel.y*vel.y))/14.5;
	return mag;
}

float gauss(vec2 p, float r) {
    return exp(-dot(p, p) / r);
}

////////////////////////////////////////////////////////////


void main() {	
	vec2 coords = vec2(gl_FragCoord.xy);
    float sourceColor = getScalarFromTextureUnsigned(texture2D(scalar_field, coords));
	float newColor = mix(sourceColor, 10.0,gauss((point-coords),radius));
	float mag = newColor/10.0;
	gl_FragColor = setScalarToTextureUnsigned(newColor,1.0*mag);
}	
	//F * dt * exp( (x-xp)2 + (y-yp)2 / r
	/*
	vec2 change = point - prevPoint;
	if (change.x < -10) {change.x = -10;}
	if (change.y < -10) {change.y = -10;}
	if (change.x > 10) {change.x = 10;}
	if (change.y > 10) {change.y = 10;}
	
	vec2 sourceVel = getVectorFromTexture(texture2D(vector_field,coords));
	vec2 newForces = change * timestep * gauss((point - coords),radius);
	vec4 gaussianSplat = setVectorToTexture(newForces);
	
//F * dt * exp( (x-xp)2 + (y-yp)2 / r
	/*
	vec2 change = point - prevPoint;
	if (change.x < -10) {change.x = -10;}
	if (change.y < -10) {change.y = -10;}
	if (change.x > 10) {change.x = 10;}
	if (change.y > 10) {change.y = 10;}
	
	vec2 sourceVel = getVectorFromTexture(texture2D(vector_field,coords));
	vec2 newForces = change * timestep * gauss((point - coords),radius);
	vec4 gaussianSplat = setVectorToTexture(newForces);
	
	
}
*/