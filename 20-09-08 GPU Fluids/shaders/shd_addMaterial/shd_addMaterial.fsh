//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;


uniform vec2 point;
uniform float radius;
//uniform vec3 fillColor;

uniform sampler2D scalar_field;


float gauss(vec2 p, float r) {
    return exp(-dot(p, p) / r);
}


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
	float newScalar = (colorValues.r)/255.0;
	newScalar = (newScalar * 10.0);
	return newScalar;
}

vec4 setScalarToTextureUnsigned(float scalar){
	float normalizedScalar = (scalar/10.0) * 255.0;
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
	vec2 coords = gl_FragCoord.xy;
	float sourceDensity = getScalarFromTextureUnsigned(texture2D(scalar_field,coords));
	if (distance(point,coords) < radius)
	{
		sourceDensity = 10.0;//mix(sourceColor,fillColor,gauss(point - coords, radius));}\
		gl_FragColor = setScalarToTextureUnsigned(sourceDensity);
	}
	else
	{
	gl_FragColor = setScalarToTextureUnsigned(sourceDensity);
	}
	
	/*
	vec2 coords = vec2(gl_FragCoord.xy);
    vec4 sourceColor = texture2D(scalar_field, coords);
	vec4 color;
	color = vec4(mix(sourceColor.xyz, fillColor, gauss(point - coords, radius)), gauss(point - coords, radius));
	
	// vec4 color = vec4(mix(sourceColor.xyz, fillColor, gauss(point - coords, radius)), sourceColor.w+0.5);
	gl_FragColor = color * texture2D( scalar_field,coords );
	*/
}

	/*
	vec2 coords = vec2(gl_FragCoord.xy);
    float sourceColor = getScalarFromTextureUnsigned(texture2D(scalar_field, coords));
	if (distance(point,coords) < radius)
	{
		sourceColor = 10.0;//mix(sourceColor,fillColor,gauss(point - coords, radius));}\
		gl_FragColor = setScalarToTextureUnsigned(sourceColor);
	}
	else
	{
	gl_FragColor = setScalarToTextureUnsigned(sourceColor);
	}
	*/

