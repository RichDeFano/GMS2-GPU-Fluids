/* Subtracts the gradient. */

//out vec2 color;

//uniform float rHalfScale;

uniform sampler2D pressure_field;
uniform sampler2D velocity_field;
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

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

void main() {
    vec2 coords = vec2(gl_FragCoord.xy);

    // Get the pressures from our neighboring cells
    vec2 center = getVectorFromTexture(texture2D(velocity_field, coords));
    float left = getScalarFromTexture(texture2D(pressure_field, coords + vec2(-1, 0)));
    float right = getScalarFromTexture(texture2D(pressure_field, coords + vec2(1, 0)));
    float bottom = getScalarFromTexture(texture2D(pressure_field, coords + vec2(0, -1)));
    float top = getScalarFromTexture(texture2D(pressure_field, coords + vec2(0, 1)));

    vec2 gradient = center - 0.5 * vec2(right - left, top - bottom);
	
	gl_FragColor = setVectorToTexture(gradient);// * texture2D( gm_BaseTexture, v_vTexcoord );
}