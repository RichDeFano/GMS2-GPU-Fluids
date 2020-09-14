varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform vec2 prevPoint;
uniform float timestep;
uniform vec2 point;
uniform float radius;
//uniform vec3 fillColor;

//uniform vec2 size;
//uniform float scale;

uniform sampler2D vector_field;


float gauss(vec2 p, float r) {
    return exp(-dot(p, p) / r);
}

vec2 getVectorFromTexture(vec4 colorValues){
	vec2 newVector = vec2(colorValues.xy + ((colorValues.zw)/255.0));
	newVector = (newVector - (128.0/255.0)) * 10.0;
	return newVector;
}

vec4 setVectorToTexture(vec2 vector){
	vec2 normalizedVector = (vector/10.0) + (128.0/255.0);
	vec4 newVTexture = vec4(normalizedVector,0.0,1.0);
	return newVTexture;
}


void main()
{
    vec2 coords = gl_FragCoord.xy;
	//F * dt * exp( (x-xp)2 + (y-yp)2 / r
	vec2 change = point - prevPoint;
	if (change.x < -10.0) {change.x = -10.0;}
	if (change.y < -10.0) {change.y = -10.0;}
	if (change.x > 10.0) {change.x = 10.0;}
	if (change.y > 10.0) {change.y = 10.0;}
	//if ((change.x < 0.25) && (change.y < 0.25)) && ((change.x > -0.25) && (change.y > -0.25))
	
	vec2 sourceVel = getVectorFromTexture(texture2D(vector_field,coords));
	vec2 newForces = change * timestep * gauss((point - coords),radius);
	gl_FragColor = setVectorToTexture(newForces);
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
	
	
}*/
