//#define FLOAT_16_OFFSET (128.0 / 255.0)

varying vec2 v_vTexcoord;

//u//niform float initial_value_pressure;
//uniform vec2 texel_size;

//vec2 unpack_uvec2_16(vec4 data) {return vec2(data.xy + (data.zw / 255.0));}
//vec2 pack_ufloat_16(float data) {return vec2(floor(data * 255.0) / 255.0, fract(data * 255.0));}

//out float divergence;
//uniform float rHalfScale;
uniform sampler2D velocity_field;

vec2 getVelocityFromTexture(vec4 colorValues){
	vec2 newVelocity = vec2(colorValues.xy + ((colorValues.zw)/255.0));
	newVelocity = (newVelocity - (128.0/255.0)) * 5.0;
	return newVelocity;
}

vec4 setDivergenceToTexture(float data) {
	return vec4(0.0,0.0,(floor(data * 255.0) / 255.0, fract(data * 255.0));
}


void main() {
	vec2 coords = vec2(gl_FragCoord.xy);
    vec2 left = getVelocityFromTexture(texture2D(velocity_field, coords - vec2(-1.0, 0.0)));//.xy;//texelFetchOffset(pressure, coords, 0, ivec2(-1, 0));
    vec2 right = getVelocityFromTexture(texture2D(velocity_field, coords + vec2(1.0, 0.0)));//.xy;
    vec2 bottom = getVelocityFromTexture(texture2D(velocity_field, coords + vec2(0.0, -1.0)));//.xy;
    vec2 top = getVelocityFromTexture(texture2D(velocity_field, coords + vec2(0.0, 1.0)));//.xy;
	
	gl_FragColor = setDivergenceToTexture(clamp( (0.5 * ((right.x - left.x) + (bottom.y - top.y)) ) + (128.0/255.0),0.0,1.0 )) ;

	
}
