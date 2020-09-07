//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;


uniform vec2 point;
uniform float radius;
uniform vec3 fillColor;

uniform sampler2D scalar_field;


float gauss(vec2 p, float r) {
    return exp(-dot(p, p) / r);
}

float getScalarFromTexture(vec4 colorValues){
	float newScalar = (colorValues.x) + (colorValues.y / 255.0);
	newScalar = (newScalar * 10.0);
	return newScalar;
}

vec4 setScalarToTexture(float scalar){
	float normalizedScalar = scalar/10.0;
	vec4 newSTexture = vec4(normalizedScalar,0.0,0.0,1.0);
	return newSTexture;
}

void main() {
	
	 vec2 coords = vec2(gl_FragCoord.xy);
    vec4 sourceColor = texture2D(scalar_field, coords);
	vec4 color;
	/*
	if (sourceColor == vec4(0.0,0.0,0.0,0.0))
	{
    color = vec4(mix(sourceColor.xyz, fillColor, gauss(point - coords, radius)), 0.0);
	}
	else
	{
	*/
	color = vec4(mix(sourceColor.xyz, fillColor, gauss(point - coords, radius)), gauss(point - coords, radius));
	
	// vec4 color = vec4(mix(sourceColor.xyz, fillColor, gauss(point - coords, radius)), sourceColor.w+0.5);
	gl_FragColor = color;// * texture2D( vector_field,coords );
	
	/*
	vec2 coords = vec2(gl_FragCoord.xy);
    float sourceColor = getScalarFromTexture(texture2D(scalar_field, coords));
	//vec4 color = setScalarToTexture(sourceColor);

	float newColor = mix(sourceColor, 255.0, gauss(point - coords, radius));
	
	// vec4 color = vec4(mix(sourceColor.xyz, fillColor, gauss(point - coords, radius)), sourceColor.w+0.5);
	gl_FragColor = setScalarToTexture(newColor);// * texture2D( vector_field,coords );
	/*
	vec2 coords = vec2(gl_FragCoord.xy);
    float dens = getScalarFromTexture(texture2D(scalar_field,coords));
	if (distance(point,coords) < radius){
		dens = mix(dens,255.0,gauss(point - coords, radius));
	}
    gl_FragColor = setScalarToTexture(dens);
	/*
    vec2 coords = vec2(gl_FragCoord.xy);
    float sourceScalar = getScalarFromTexture(texture2D(scalar_field, coords));
	if (distance(coords, point) < radius) {
		vec4 color = vec4(255.0,0.0,0.0,gauss(point - coords,radius));
		float colorSca = getScalarFromTexture(color);	
		sourceScalar = sourceScalar + colorSca;
	}
	gl_FragColor = setScalarToTexture(sourceScalar);
	*/
}