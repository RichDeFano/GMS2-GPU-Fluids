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
    if (distance(coords, point) < radius) {
        color = vec4(fillColor, gauss(coords,radius));
    } else {
        color = sourceColor;
    }
	
	gl_FragColor = color;// * texture2D( gm_BaseTexture, v_vTexcoord );
}