//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;


uniform vec2 point;
uniform float radius;
uniform vec3 fillColor;

uniform sampler2D vector_field;


float gauss(vec2 p, float r) {
    return exp(-dot(p, p) / r);
}


void main() {
    vec2 coords = vec2(gl_FragCoord.xy);
    vec4 sourceColor = texture2D(vector_field, coords);
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
}