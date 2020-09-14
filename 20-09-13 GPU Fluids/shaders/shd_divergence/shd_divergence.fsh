//#define FLOAT_16_OFFSET (128.0 / 255.0)

varying vec2 v_vTexcoord;
uniform sampler2D velocity_field;
uniform float rHalfScale;


vec2 getVectorFromTexture(vec4 colorValues){
	vec2 newVector = vec2(colorValues.xy + ((colorValues.zw)/255.0));
	newVector = (newVector - (128.0/255.0)) * 10.0;
	return newVector;
}


vec4 setScalarToTexture(float scalar){
	float normalizedScalar = (scalar/10.0) + (128.0/255.0);
	vec4 newSTexture = vec4(normalizedScalar,0.0,0.0,0.0);
	return newSTexture;
}


void main() {
	vec2 coords = vec2(gl_FragCoord.xy);
    vec2 left = getVectorFromTexture(texture2D(velocity_field, coords - vec2(-1.0, 0.0)));//.xy;//texelFetchOffset(pressure, coords, 0, ivec2(-1, 0));
    vec2 right = getVectorFromTexture(texture2D(velocity_field, coords + vec2(1.0, 0.0)));//.xy;
    vec2 bottom = getVectorFromTexture(texture2D(velocity_field, coords + vec2(0.0, -1.0)));//.xy;
    vec2 top = getVectorFromTexture(texture2D(velocity_field, coords + vec2(0.0, 1.0)));//.xy;
	
	float div = (rHalfScale * ((right.x - left.x) + (bottom.y - top.y))) ;
	gl_FragColor = setScalarToTexture(div);

	
}
