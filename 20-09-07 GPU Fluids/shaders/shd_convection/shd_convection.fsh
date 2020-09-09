//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform sampler2D temperature_field;
uniform sampler2D density_field;

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
	float k = 1.0;
	float scale = 1.0;
	float dens = (-k)*getScalarFromTexture(texture2D(density_field,coords));
	
	float left = getScalarFromTexture(texture2D(temperature_field, coords + vec2(-1, 0)));
    float right = getScalarFromTexture(texture2D(temperature_field, coords + vec2(1, 0)));
    float bottom = getScalarFromTexture(texture2D(temperature_field, coords + vec2(0, -1)));
    float top = getScalarFromTexture(texture2D(temperature_field, coords + vec2(0, 1)));
	float center = getScalarFromTexture(texture2D(temperature_field, coords));
	
	float ambientTemp = (left + right + bottom + top)/4.0;
	float yComponent = dens + scale*(ambientTemp - center);

    gl_FragColor = setScalarToTexture(yComponent);
}
