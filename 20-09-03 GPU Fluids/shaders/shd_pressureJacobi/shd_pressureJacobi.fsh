//#define FLOAT_16_OFFSET (128.0 / 255.0)
uniform float alpha;
uniform float rBeta;  // reciprocal beta term

uniform sampler2D pressure_field;
uniform sampler2D divergence_field;

varying vec2 v_vTexcoord;

//uniform vec2 texel_size;

//float unpack_ufloat_16(vec2 data) {return data.x + (data.y / 255.0);}
///vec2 pack_ufloat_16(float data) {return vec2(floor(data * 255.0) / 255.0, fract(data * 255.0));}

void main() {
	/*
    float velocity_range = 10.0;
    float pressure_range = 10.0;

    gl_FragColor.zw = texture2D(gm_BaseTexture, v_vTexcoord).zw;
    float right = unpack_ufloat_16(texture2D(gm_BaseTexture, v_vTexcoord + vec2(texel_size.x, 0.0)).xy) * pressure_range;
    float left = unpack_ufloat_16(texture2D(gm_BaseTexture, v_vTexcoord - vec2(texel_size.x, 0.0)).xy) * pressure_range;
    float bottom = unpack_ufloat_16(texture2D(gm_BaseTexture, v_vTexcoord + vec2(0.0, texel_size.y)).xy) * pressure_range;
    float top = unpack_ufloat_16(texture2D(gm_BaseTexture, v_vTexcoord - vec2(0.0, texel_size.y)).xy) * pressure_range;
    
    float divergence = (unpack_ufloat_16(gl_FragColor.zw) - FLOAT_16_OFFSET) * velocity_range;
    
    gl_FragColor.xy = pack_ufloat_16(((left + right + top + bottom - divergence) * 0.25) / pressure_range);
	
	*/
 
	vec2 coords = vec2(gl_FragCoord.xy);

    // Get neighboring pressures
    vec2 left = texture2D(pressure_field, coords - vec2(-1.0, 0.0)).xy;//texelFetchOffset(pressure, coords, 0, ivec2(-1, 0));
    vec2 right = texture2D(pressure_field, coords + vec2(1.0, 0.0)).xy;
    vec2 bottom = texture2D(pressure_field, coords + vec2(0.0, -1.0)).xy;
    vec2 top = texture2D(pressure_field, coords + vec2(0.0, 1.0)).xy;

    // Get the pressure at our current cell
    vec2 center = texture2D(divergence_field,coords).xy;//texelFetch(divergence, coords, 0);

    // Calculate the Jacobi approximation for the Poisson-pressure equation
   vec2 temp = (left + right + bottom + top + alpha * center) * rBeta;
	gl_FragColor = vec4(temp,vec2(0.0,0.0)) * texture2D( gm_BaseTexture, v_vTexcoord );

}

