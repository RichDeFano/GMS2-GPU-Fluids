
uniform float alpha;
uniform float rBeta;  // reciprocal beta term

uniform sampler2D pressure_field;
uniform sampler2D divergence_field;

varying vec2 v_vTexcoord;



float getPressureFromTexture(vec2 pressureData){
	return pressureData.x + (pressureData.y / 255.0);
}

vec2 setPressureToTexture(float pressureData){
	return vec2(floor(pressureData * 255.0) / 255.0, fract(pressureData * 255.0));
}

void main() {
	vec2 coords = vec2(gl_FragCoord.xy);

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

}

