//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform float scaleA;
uniform float scaleB;

uniform sampler2D vector_field;
uniform sampler2D scalar_field;

/*
vec2 getVelocityFromTexture(vec4 colorValues){
	vec2 newVelocity = vec2(colorValues.xy + ((colorValues.zw)/255.0));
	newVelocity = (newVelocity - (128.0/255.0)) * 5.0;
	return newVelocity;
}

vec4 getTextureFromVelocity(vec2 velocity){
	vec4 newColor = vec4( floor(velocity*255.0)/255.0,fract(velocity*255.0));
	newColor = ((newColor/5.0) + (128.0/255.0));
	return newColor;
}

float getDiffusionFromTexture(vec4 diffusionData){
	float newDiffusion = (diffusionData.x);
	newDiffusion = (newDiffusion * 10.0);
	return newDiffusion;
}

vec4 setDiffusionToTexture(float diffusion){
	float normDiffusion = diffusion / 10.0;
	vec4 newDiffusion = vec4(normDiffusion,vec3(0.0,0.0,0.0));
	return newDiffusion;
}
*/
vec2 getVectorFromTexture(vec4 colorValues){
	vec2 newVelocity = vec2(colorValues.xy + ((colorValues.zw)/255.0));
	newVelocity = (newVelocity - (128.0/255.0)) * 5.0;
	return newVelocity;
}


float getScalarFromTexture(vec2 pressureData){
	float newScalar = (pressureData.x) + (pressureData.y / 255.0);
	newPressure = (newPressure * 10.0);
	return newPressure;
}

vec2 setScalarToTexture(float scalar){
	vec2 newScalar = vec2(floor(scalar*255.0)/255.0,fract(scalar * 255.0));
	newScalar = newScalar / 10.0;
	return newScalar;
}




void main()
{
	vec2 coords = vec2(gl_FragCoord.xy);
    vec4 color = scaleA * getVectorFromTexture(texture2D(vector_field, coords)) + scaleB * getScalarFromTexture(texture2D(scalar_field, coords));
	gl_FragColor = color;// * texture2D( tex_field2, coords);
	/*
    vec2 coords = vec2(gl_FragCoord.xy);
	vec2 velocity = getVelocityFromTexture(texture2D(vector_field,coords));
	float scalar = getDiffusionFromTexture(texture2D(scalar_field,coords));
	vec4 velocity = texture2D(vector_field,coords));
	vec4 scalar = texture2D(scalar_field,coords));
    vec4 color = (scaleA * velocity) + (scaleB * scalar);
	gl_FragColor = color;// * texture2D( tex_field2, coords);
	*/
}
