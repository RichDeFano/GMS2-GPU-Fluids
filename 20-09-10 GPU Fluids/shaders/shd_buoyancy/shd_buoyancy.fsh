//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform float alpha;
uniform float beta;
uniform sampler2D density_field;
uniform sampler2D temperature_field;


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


void main()
{
	vec2 coords = gl_FragCoord.xy;
	//force_buoy = ((-alpha)*(scalar_field)) + ((beta)*(temp - 0)).j;
	float f_buoy = ( (-alpha * getScalarFromTextureUnsigned(texture2D(density_field,coords))) + ( (beta) * (getScalarFromTextureUnsigned(texture2D(temperature_field,coords)) - 0.0)));
	//vec2 vel = getVectorFromTexture(texture2D(velocity_field,coords));
	//vel.y = (vel.y+f_buoy);
    gl_FragColor = setScalarToTextureUnsigned(f_buoy);//v_vColour * texture2D( gm_BaseTexture, v_vTexcoord );
}
