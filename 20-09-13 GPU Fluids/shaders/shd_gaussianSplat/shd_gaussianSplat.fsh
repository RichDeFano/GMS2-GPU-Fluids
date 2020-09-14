//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

//uniform vec2 prevPoint;
//uniform float timestep;
uniform vec2 point;
uniform float radius;
uniform vec3 fillColor;

uniform vec2 size;
uniform float scale;

uniform sampler2D scalar_field;


float gauss(vec2 p, float r) {
    return exp(-dot(p, p) / r);
}

float getScalarFromTexture(vec4 colorValues){
	float newScalar = (colorValues.x) + (colorValues.y / 255.0);
	newScalar = (newScalar * 10.0);
	return newScalar;
}

vec4 setScalarToTexture(float scalar){
	float normalizedScalar = scalar/10.0;
	vec4 newSTexture = vec4(normalizedScalar,0.0,0.0,1.0);
	return newSTexture;
}

void main() {
	
	 vec2 coords = vec2(gl_FragCoord.xy);
    vec4 sourceColor = texture2D(scalar_field, coords);
	vec4 color;
	color = vec4(mix(sourceColor.xyz, fillColor, gauss((point - coords), radius)), gauss((point - coords), radius));
	
	// vec4 color = vec4(mix(sourceColor.xyz, fillColor, gauss(point - coords, radius)), sourceColor.w+0.5);
	gl_FragColor = color;// * texture2D( vector_field,coords );
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
	
	
}
*/