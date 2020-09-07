
uniform float alpha;
uniform float rBeta;  // reciprocal beta term

uniform sampler2D pressure_field;
uniform sampler2D divergence_field;

varying vec2 v_vTexcoord;



/*
float getPressureFromTexture(vec2 pressureData){
	return pressureData.x + (pressureData.y / 255.0);
}

vec2 setPressureToTexture(float pressureData){
	return vec2(floor(pressureData * 255.0) / 255.0, fract(pressureData * 255.0));
}
*/

float getPressureFromTexture(vec2 pressureData){
	float newPressure = (pressureData.x) + (pressureData.y / 255.0);
	newPressure = (newPressure * 10.0);
	return newPressure;
}

vec2 setPressureToTexture(float pressure){
	vec2 newPressure = vec2(floor(pressure*255.0)/255.0,fract(pressure * 255.0));
	newPressure = newPressure / 10.0;
	return newPressure;
}


//vec2 pack_ufloat_16(float data) {return vec2(floor(data * 255.0) / 255.0, fract(data * 255.0));}

/*
    gl_FragColor.zw = texture2D(gm_BaseTexture, v_vTexcoord).zw;
    float right = unpack_ufloat_16(texture2D(gm_BaseTexture, v_vTexcoord + vec2(texel_size.x, 0.0)).xy) * pressure_range;
    float left = unpack_ufloat_16(texture2D(gm_BaseTexture, v_vTexcoord - vec2(texel_size.x, 0.0)).xy) * pressure_range;
    float bottom = unpack_ufloat_16(texture2D(gm_BaseTexture, v_vTexcoord + vec2(0.0, texel_size.y)).xy) * pressure_range;
    float top = unpack_ufloat_16(texture2D(gm_BaseTexture, v_vTexcoord - vec2(0.0, texel_size.y)).xy) * pressure_range;
    
    float divergence = (unpack_ufloat_16(gl_FragColor.zw) - FLOAT_16_OFFSET) * velocity_range;
    
    gl_FragColor.xy = pack_ufloat_16(((left + right + top + bottom - divergence) * 0.25) / pressure_range);
	*/

void main() {
	//gl_FragColor.zw = getPressureFromTexture(texture2D(gm_BaseTexture,v_vTexcoord).zw);
	gl_FragColor.zw = texture2D(gm_BaseTexture, v_vTexcoord).zw;
	vec2 coords = vec2(gl_FragCoord.xy);

	    // Get the pressures from our neighboring cells
    //vec2 center = getVelocityFromTexture(texture2D(velocity_field, coords));
    float left = getPressureFromTexture(texture2D(pressure_field, coords + vec2(-1, 0)).xy);
    float right = getPressureFromTexture(texture2D(pressure_field, coords + vec2(1, 0)).xy);
    float bottom = getPressureFromTexture(texture2D(pressure_field, coords + vec2(0, -1)).xy);
    float top = getPressureFromTexture(texture2D(pressure_field, coords + vec2(0, 1)).xy);

	float div = (getPressureFromTexture(texture2D(divergence_field,coords).xy) - (128.0/255.0));
   // vec2 gradient = center - 0.5 * vec2(right - left, top - bottom);

	//float div = getPressureFromTexture(texture2D(divergence_field,coords).xy);//texelFetch(divergence, coords, 0);

    // Calculate the Jacobi approximation for the Poisson-pressure equation
    float temp = ((left + right + bottom + top + alpha * div) * rBeta)/10.0;
	gl_FragColor.xy = setPressureToTexture(temp);// * texture2D( pressure_field, coords );

/*
    // Get neighboring pressures
    float left = getPressureFromTexture(texture2D(pressure_field, coords - vec2(-1.0, 0.0)).xy) * 10.0;//texelFetchOffset(pressure, coords, 0, ivec2(-1, 0));
    float right = getPressureFromTexture(texture2D(pressure_field, coords + vec2(1.0, 0.0)).xy) * 10.0;
    float bottom = getPressureFromTexture(texture2D(pressure_field, coords + vec2(0.0, -1.0)).xy) * 10.0;
    float top = getPressureFromTexture(texture2D(pressure_field, coords + vec2(0.0, 1.0)).xy) * 10.0;

    // Get the pressure at our current cell
    float center = getPressureFromTexture(texture2D(divergence_field,coords).xy);//texelFetch(divergence, coords, 0);

    // Calculate the Jacobi approximation for the Poisson-pressure equation
   vec2 temp = setPressureToTexture(((left + right + bottom + top + alpha * center) * rBeta)/10.0);
	gl_FragColor = vec4(temp,vec2(0.0,0.0));// * texture2D( pressure_field, coords );
	*/

}

