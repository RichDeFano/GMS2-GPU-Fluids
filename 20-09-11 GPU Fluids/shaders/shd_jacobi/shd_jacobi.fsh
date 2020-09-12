
uniform float alpha;
uniform float rBeta;  // reciprocal beta term

uniform sampler2D pressure_field;
uniform sampler2D divergence_field;

varying vec2 v_vTexcoord;


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

    float left = getScalarFromTexture(texture2D(pressure_field, coords + vec2(-1, 0)));
    float right = getScalarFromTexture(texture2D(pressure_field, coords + vec2(1, 0)));
    float bottom = getScalarFromTexture(texture2D(pressure_field, coords + vec2(0, -1)));
    float top = getScalarFromTexture(texture2D(pressure_field, coords + vec2(0, 1)));

	float div = getScalarFromTexture(texture2D(divergence_field,coords));

    float temp = ((left + right + bottom + top + alpha * div) * rBeta);
	gl_FragColor = setScalarToTexture(temp);
}

