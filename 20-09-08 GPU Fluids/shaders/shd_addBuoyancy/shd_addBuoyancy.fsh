//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

//
// Simple passthrough fragment shader

uniform float scaleA;
uniform float scaleB;

uniform sampler2D vector_field;
uniform sampler2D scalar_field;


vec2 getVectorFromTexture(vec4 colorValues){
	vec2 newVector = vec2(colorValues.x - 128.0,colorValues.y - 128.0);
	newVector = (newVector/255.0) * 10.0;
	return newVector;
}

vec4 setVectorToTexture(vec2 vector){
	vec2 normalizedVector = ((vector/10.0) + (128.0))/255.0;
	vec4 newVTexture = vec4(normalizedVector,0.0,0.0);
	return newVTexture;
}

float getScalarFromTextureUnsigned(vec4 colorValues){
	float newScalar = (colorValues.x)/255.0;
	newScalar = (newScalar * 10.0);
	return newScalar;
}

vec4 setScalarToTextureUnsigned(float scalar){
	float normalizedScalar = (scalar/10.0) * 255.0;
	vec4 newSTexture = vec4(normalizedScalar,0.0,0.0,0.0);
	return newSTexture;
}



void main()
{

	vec2 coords = vec2(gl_FragCoord.xy);
	vec2 vel = (scaleA * getVectorFromTexture(texture2D(vector_field,coords)));
	float buoy = (scaleB * getScalarFromTextureUnsigned(texture2D(scalar_field,coords)));
	vel.y = (vel.y + buoy);
   // vec2 color = ((scaleA * getVectorFromTexture(texture2D(vector_field, coords))) * (scaleB * getScalarFromTexture(texture2D(scalar_field, coords))));
	gl_FragColor = setVectorToTexture(vel);// * texture2D( tex_field2, coords);
	

}
