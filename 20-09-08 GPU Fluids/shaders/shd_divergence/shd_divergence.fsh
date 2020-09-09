//#define FLOAT_16_OFFSET (128.0 / 255.0)

varying vec2 v_vTexcoord;
uniform sampler2D velocity_field;




vec4 setScalarToTextureSigned(float scalar){
	float normalizedScalar = ((scalar/10.0) + 128.0)/255.0;
	vec4 newSTexture = vec4(normalizedScalar,0.0,0.0,0.0);
	return newSTexture;
}

vec2 getVectorFromTexture(vec4 colorValues){
	vec2 newVector = vec2(colorValues.x - 128.0,colorValues.y - 128.0);
	newVector = (newVector/255.0) * 10.0;
	return newVector;
}



void main() {
	vec2 coords = vec2(gl_FragCoord.xy);
    vec2 left = getVectorFromTexture(texture2D(velocity_field, coords - vec2(-1.0, 0.0)));//.xy;//texelFetchOffset(pressure, coords, 0, ivec2(-1, 0));
    vec2 right = getVectorFromTexture(texture2D(velocity_field, coords + vec2(1.0, 0.0)));//.xy;
    vec2 bottom = getVectorFromTexture(texture2D(velocity_field, coords + vec2(0.0, -1.0)));//.xy;
    vec2 top = getVectorFromTexture(texture2D(velocity_field, coords + vec2(0.0, 1.0)));//.xy;
	
	float div = (0.5 * ((right.x - left.x) + (bottom.y - top.y))) ;
	gl_FragColor = setScalarToTextureSigned(div);

	
}
