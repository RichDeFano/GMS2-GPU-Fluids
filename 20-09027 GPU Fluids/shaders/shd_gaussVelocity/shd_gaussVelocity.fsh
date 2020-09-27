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


///////////////////////////////////////////////////////////////////////////////////////////
#define VECTOR_RANGE 10.0
#define SCALAR_RANGE 10.0
vec2 getVectorFromTexture(vec4 colorValues){
	vec2 newVector = vec2((colorValues.x - 127.5)/127.5,(colorValues.y - 127.5)/127.5);
	newVector = newVector * VECTOR_RANGE;
	return newVector;
}

vec4 setVectorToTexture(vec2 vector,float alpha){
	vec2 normalizedVector = vec2( ((vector.x/VECTOR_RANGE) * (127.5)) + 127.5,((vector.y/VECTOR_RANGE) * (127.5)) + 127.5);
	vec4 newVTexture = vec4(normalizedVector,0.0,alpha);
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
	float newScalar = (colorValues.x - 127.5)/127.5;
	newScalar = (newScalar * SCALAR_RANGE);
	return newScalar;
}

vec4 setScalarToTextureSigned(float scalar){
	float normalizedScalar = ((scalar/SCALAR_RANGE) * (127.5)) + 127.5;
	vec4 newSTexture = vec4(normalizedScalar,0.0,0.0,1.0);
	return newSTexture;
}

float magnitude(vec2 vel){
	float mag = sqrt((vel.x*vel.x)+(vel.y*vel.y))/sqrt((VECTOR_RANGE*VECTOR_RANGE)+(VECTOR_RANGE*VECTOR_RANGE));
	return mag;
}

float gauss(vec2 p, float r) {
    return exp(-dot(p, p) / r);
}

////////////////////////////////////////////////////////////


void main()
{
	
	vec2 coords = gl_FragCoord.xy;
	vec2 change = point - prevPoint;
	//F * dt * exp( (x-xp)2 + (y-yp)2 / r
	if (change.x < -10.0) {change.x = -10.0;}
	if (change.y < -10.0) {change.y = -10.0;}
	if (change.x > 10.0) {change.x = 10.0;}
	if (change.y > 10.0) {change.y = 10.0;}
	
	vec4 fourChange = vec4(change,0.0,1.0);
	vec4 sourceColor = texture2D(gm_BaseTexture, v_vTexcoord);
	//vec2 velColor = getVectorFromTexture(texture2D(gm_BaseTexture, v_vTexcoord));
	vec4 velColor = sourceColor;
	velColor += mix(velColor, fourChange,gauss((point-coords),radius));
	//float mag = magnitude(velColor);
	//mag = clamp(mag,0.0,1.0);
	gl_FragColor = velColor;//setVectorToTexture(velColor,1.0);
	/*
	vec4 newColor = sourceColor;
	if (abs(distance(point,coords)) < radius)
	{
	newColor = mix(sourceColor, fourChange,gauss((point-coords),radius));
	}
	//float mag = newColor/SCALAR_RANGE;
	gl_FragColor = newColor;
	*/
	
}
	/*

	vec2 sourceColor = getVectorFromTexture(texture2D(gm_BaseTexture, v_vTexcoord));
	vec2 newColor;
	if (distance(coords,point) < radius)
	{
	newColor = mix(sourceColor, change,gauss((point-coords),radius));
	}
	else
	{newColor = sourceColor;}
	
	
	float magX = abs(newColor.x) / 10.0;
	float magY = abs(newColor.y) / 10.0;
	float average = (magX + magY);
	
	//float average = magnitude(newColor);
	gl_FragColor = setVectorToTexture(newColor,1.0);
}
	/*
    vec2 coords = gl_FragCoord.xy;
	vec2 change = point - prevPoint;
	//F * dt * exp( (x-xp)2 + (y-yp)2 / r
	/*
	vec2 change = point - prevPoint;
	if (change.x < -10.0) {change.x = -10.0;}
	if (change.y < -10.0) {change.y = -10.0;}
	if (change.x > 10.0) {change.x = 10.0;}
	if (change.y > 10.0) {change.y = 10.0;}
	
	//if ((change.x < 0.25) && (change.y < 0.25)) && ((change.x > -0.25) && (change.y > -0.25))
	vec2 sourceVel = getVectorFromTexture(texture2D(vector_field,coords));
	if (distance(point,coords) < radius)
	{
	sourceVel = mix(sourceVel,change,gauss((point - coords),radius));
	}
	float magX = sourceVel.x / 10.0;
	float magY = sourceVel.y / 10.0;
	float average = (magX + magY) / 2.0;
	gl_FragColor = setVectorToTexture(sourceVel,1.0);
	*/

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
