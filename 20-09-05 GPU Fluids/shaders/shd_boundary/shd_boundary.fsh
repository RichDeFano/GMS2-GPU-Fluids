//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;


uniform int width;
uniform int height;

uniform sampler2D vector_field; // either the velocity or pressure field

void main() {
    ivec2 coords = ivec2(gl_FragCoord.xy);
    int x = coords.x;
    int y = coords.y;

	vec4 bounded;
    if (x == 0 || x == width - 1 || y == 0 || y == height - 1) { // At a boundary
        bounded = vec4(0, 0, 0, 0);
    } else {
        bounded = texture2D(vector_field, vec2(coords) );
    }
	
	gl_FragColor = bounded;// * texture2D( gm_BaseTexture, v_vTexcoord );
}