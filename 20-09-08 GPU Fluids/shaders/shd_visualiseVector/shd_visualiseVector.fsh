//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform sampler2D vector_field;


vec2 getVectorFromTexture(vec4 colorValues){
	vec2 newVector = vec2(colorValues.x - 128.0,colorValues.y - 128.0);
	newVector = (newVector/128.0) * 10.0;
	return newVector;
}

vec4 setVectorToTexture(vec2 vector,float alph){
	vec2 normalizedVector;
	normalizedVector.x = ((vector.x/10.0) * 128.0) + 128.0;
	normalizedVector.y = ((vector.y/10.0) * 128.0) + 128.0;
	vec4 newVTexture = vec4(normalizedVector,0.0,1.0);
	return newVTexture;
}



float magnitude(vec2 inVec){
	return clamp(sqrt((inVec.x*inVec.x) + (inVec.y*inVec.y))/10.0,0.0,1.0);
}

void main()
{
	vec2 coords = gl_FragCoord.xy;
	vec2 vel = getVectorFromTexture(texture2D(vector_field,coords));	
	float mag = magnitude(vel);
	gl_FragColor = setVectorToTexture(vel,0.0) * texture2D( gm_BaseTexture, v_vTexcoord );
	
}
