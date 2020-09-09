//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform sampler2D temperature_field;
uniform sampler2D density_field;

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
	vec2 coords = gl_FragCoord.xy;
	float k = 1.0;
	float scale = 1.0;
	float dens = (-k)*getScalarFromTextureUnsigned(texture2D(density_field,coords));
	
	float left = getScalarFromTextureUnsigned(texture2D(temperature_field, coords + vec2(-1, 0)));
    float right = getScalarFromTextureUnsigned(texture2D(temperature_field, coords + vec2(1, 0)));
    float bottom = getScalarFromTextureUnsigned(texture2D(temperature_field, coords + vec2(0, -1)));
    float top = getScalarFromTextureUnsigned(texture2D(temperature_field, coords + vec2(0, 1)));
	float center = getScalarFromTextureUnsigned(texture2D(temperature_field, coords));
	
	float ambientTemp = (left + right + bottom + top)/4.0;
	float yComponent = dens + scale*(ambientTemp - center);

    gl_FragColor = setScalarToTextureUnsigned(yComponent);
}
