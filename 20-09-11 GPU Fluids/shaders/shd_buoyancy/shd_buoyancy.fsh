//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;


uniform float alpha;
uniform float beta;

uniform sampler2D density_field;
uniform sampler2D temperature_field;
uniform sampler2D velocity_field;


float getScalarFromTexture(vec4 colorValues){
	float newScalar = (colorValues.x) + (colorValues.y / 255.0);
	newScalar = (newScalar * 10.0);
	return newScalar;
}

vec4 setScalarToTexture(float scalar){
	float normalizedScalar = scalar/10.0;
	vec4 newSTexture = vec4(normalizedScalar,0.0,0.0,0.0);
	return newSTexture;
}

vec2 getVectorFromTexture(vec4 colorValues){
	vec2 newVector = vec2(colorValues.xy + ((colorValues.zw)/255.0));
	newVector = (newVector - (128.0/255.0)) * 10.0;
	return newVector;
}

vec4 setVectorToTexture(vec2 vector){
	vec2 normalizedVector = (vector/10.0) + (128.0/255.0);
	vec4 newVTexture = vec4(normalizedVector,0.0,0.0);
	return newVTexture;
}


void main()
{
	vec2 coords = gl_FragCoord.xy;
	//force_buoy = ((-alpha)*(scalar_field)) + ((beta)*(temp - 0)).j;
	float f_buoy = ( (-alpha * getScalarFromTexture(texture2D(density_field,coords))) + ( (beta) * (getScalarFromTexture(texture2D(temperature_field,coords)) - 0.0)));
	vec2 vel = getVectorFromTexture(texture2D(velocity_field,coords));
	vel.y = (vel.y*f_buoy);
    gl_FragColor = setVectorToTexture(vel);//v_vColour * texture2D( gm_BaseTexture, v_vTexcoord );
}
