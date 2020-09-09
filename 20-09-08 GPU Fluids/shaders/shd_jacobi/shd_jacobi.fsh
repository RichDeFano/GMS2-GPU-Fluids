
uniform float alpha;
uniform float rBeta;  // reciprocal beta term

uniform sampler2D pressure_field;
uniform sampler2D divergence_field;

varying vec2 v_vTexcoord;


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

float getScalarFromTextureSigned(vec4 colorValues){
	float newScalar = (colorValues.x - 128.0)/255.0;
	newScalar = (newScalar * 10.0);
	return newScalar;
}



void main() {
	
	vec2 coords = vec2(gl_FragCoord.xy);

    float left = getScalarFromTextureUnsigned(texture2D(pressure_field, coords + vec2(-1, 0)));
    float right = getScalarFromTextureUnsigned(texture2D(pressure_field, coords + vec2(1, 0)));
    float bottom = getScalarFromTextureUnsigned(texture2D(pressure_field, coords + vec2(0, -1)));
    float top = getScalarFromTextureUnsigned(texture2D(pressure_field, coords + vec2(0, 1)));

	float div = getScalarFromTextureSigned(texture2D(divergence_field,coords));

    float temp = ((left + right + bottom + top + alpha * div) * rBeta);
	gl_FragColor = setScalarToTextureUnsigned(temp);
}

