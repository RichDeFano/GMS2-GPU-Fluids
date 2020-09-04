//#define FLOAT_16_OFFSET (128.0 / 255.0)

varying vec2 v_vTexcoord;

//u//niform float initial_value_pressure;
//uniform vec2 texel_size;

//vec2 unpack_uvec2_16(vec4 data) {return vec2(data.xy + (data.zw / 255.0));}
//vec2 pack_ufloat_16(float data) {return vec2(floor(data * 255.0) / 255.0, fract(data * 255.0));}

//out float divergence;
//uniform float rHalfScale;
uniform sampler2D velocity_field;

void main() {
	/*
    vec2 right = unpack_uvec2_16(texture2D(gm_BaseTexture, v_vTexcoord + vec2(texel_size.x, 0.0))) - FLOAT_16_OFFSET;
    vec2 left = unpack_uvec2_16(texture2D(gm_BaseTexture, v_vTexcoord - vec2(texel_size.x, 0.0))) - FLOAT_16_OFFSET;
    vec2 bottom = unpack_uvec2_16(texture2D(gm_BaseTexture, v_vTexcoord + vec2(0.0, texel_size.y))) - FLOAT_16_OFFSET;
    vec2 top = unpack_uvec2_16(texture2D(gm_BaseTexture, v_vTexcoord - vec2(0.0, texel_size.y))) - FLOAT_16_OFFSET;
    
    gl_FragColor = vec4(initial_value_pressure, 0.0, pack_ufloat_16(clamp((0.5 * ((right.x - left.x) + (bottom.y - top.y))) + FLOAT_16_OFFSET, 0.0, 1.0)));
	*/
	vec2 coords = vec2(gl_FragCoord.xy);
    vec2 left = texture2D(velocity_field, coords - vec2(-1.0, 0.0)).xy;//texelFetchOffset(pressure, coords, 0, ivec2(-1, 0));
    vec2 right = texture2D(velocity_field, coords + vec2(1.0, 0.0)).xy;
    vec2 bottom = texture2D(velocity_field, coords + vec2(0.0, -1.0)).xy;
    vec2 top = texture2D(velocity_field, coords + vec2(0.0, 1.0)).xy;

    vec2 color = 0.5 * (right - left + top - bottom);
	gl_FragColor = vec4(color,vec2(0.0,0.0));// * texture2D( gm_BaseTexture, v_vTexcoord );
	
}
