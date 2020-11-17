varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform vec2 rSize;
uniform float rScale;
uniform float timestep;
uniform float dissipation;

uniform sampler2D velocity_field;
uniform sampler2D advected_field;

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

void main()
{
	vec2 coords = gl_FragCoord.xy;
	//vec2 pos = rSize * (coords - timestep * rScale * getVectorFromTexture(texture2D(velocity_field, rSize * coords)));
	vec2 pos = (coords - timestep * rScale * getVectorFromTexture(texture2D(velocity_field, coords)));
	vec4 color = dissipation * texture2D(gm_BaseTexture, pos);
	gl_FragColor = color;// * texture2D( gm_BaseTexture, coords );
	/*
	vec2 coords = gl_FragCoord.xy;

	vec2 v = getVectorFromTexture(texture2D(velocity_field, rSize * coords));
	vec2 pos = rSize * (coords - timestep * rScale * v);
	vec2 adVel = dissipation * getVectorFromTexture(texture2D(advected_field,pos));
	gl_FragColor = setVectorToTexture(adVel);
	*/

}