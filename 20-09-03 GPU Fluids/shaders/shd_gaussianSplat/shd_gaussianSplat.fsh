//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;


uniform vec2 point;
uniform float radius;
uniform vec3 fillColor;

uniform sampler2D source_field;


float gauss(vec2 p, float r) {
    return exp(-dot(p, p) / r);
}


void main() {
    vec2 coords = vec2(gl_FragCoord.xy);
    vec4 sourceColor = texture2D(source_field, coords);

    vec4 color = vec4(mix(sourceColor.xyz, fillColor, gauss(point - coords, radius)), 1.0);
	gl_FragColor = color * texture2D( gm_BaseTexture, v_vTexcoord );
}