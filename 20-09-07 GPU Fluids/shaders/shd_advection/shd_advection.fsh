varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform vec2 rSize;
uniform float rScale;
uniform float timestep;
uniform float dissipation;

uniform sampler2D velocity_field;
uniform sampler2D advected_field;

vec2 getVectorFromTexture(vec4 colorValues){
	vec2 newVector = vec2(colorValues.xy + ((colorValues.zw)/255.0));
	newVector = (newVector - (128.0/255.0)) * 10.0;
	return newVector;
}
/*
vec4 setVectorToTexture(vec2 vector){
	vec2 normalizedVector = (vector/10.0) + (128.0/255.0);
	vec4 newVTexture = vec4(normalizedVector,0.0,0.0);
	return newVTexture;
}*/


void main()
{
	vec2 coords = gl_FragCoord.xy;
	vec2 pos = rSize * (coords - timestep * rScale * getVectorFromTexture(texture2D(velocity_field, rSize * coords)));
	vec4 color = dissipation * texture2D( advected_field, pos);
	gl_FragColor = color;// * texture2D( gm_BaseTexture, coords );
	/*
	vec2 coords = gl_FragCoord.xy;

	vec2 v = getVectorFromTexture(texture2D(velocity_field, rSize * coords));
	vec2 pos = rSize * (coords - timestep * rScale * v);
	vec2 adVel = dissipation * getVectorFromTexture(texture2D(advected_field,pos));
	gl_FragColor = setVectorToTexture(adVel);
	*/

}

