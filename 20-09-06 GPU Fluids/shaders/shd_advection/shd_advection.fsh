varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform vec2 rSize;
uniform float rScale;
uniform float timestep;
uniform float dissipation;

uniform sampler2D velocity_field;
uniform sampler2D advected_field;

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

	

void main()
{
	vec2 coords = gl_FragCoord.xy;
	//vec2 xOffset = vec2(1.0,0.0);
	//vec2 yOffset = vec2(0.0,1.0);
	vec2 velocity = getVelocityFromTexture(texture2D(velocity_field, rSize * coords));
	
	vec2 pos = rSize * (coords - timestep * rScale * velocity);
	
	//vec2 finalVel = getVelocityFromTexture(texture2D(velocity_field,pos));
	vec4 finalTex = dissipation * texture2D(advected_field,pos);
	gl_FragColor = finalTex;
	/*
	vec2 top = getVelocityFromTexture(texture2D(velocity_field,coords + yOffset));
	vec2 bottom = getVelocityFromTexture(texture2D(velocity_field,coords-yOffset));
	vec2 right = getVelocityFromTexture(texture2D(velocity_field,coords + xOffset));
	vec2 left = getVelocityFromTexture(texture2D(velocity_field,coords - xOffset));
	/*
	vec2 pos = rSize * (coords - timestep * rScale * getVelocityFromTexture(texture2D(velocity_field, rSize * coords)));
	vec4 color = dissipation * texture2D( advected_field, pos);
	gl_FragColor = color;// * texture2D( gm_BaseTexture, coords );
	vec4 color = dissipation * bilinear_interpolation(advected_field,pos);
	gl_FragColor = color;
	*/
}
