//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;


uniform vec2 size;
uniform float rHalfScale;

uniform sampler2D velocity_field;


void main() {
    vec2 coords = gl_FragCoord.xy / size.xy;

    vec2 xOffset = vec2(1.0 / size.x, 0.0);
    vec2 yOffset = vec2(0.0, 1.0 / size.y);

    float left = texture2D(velocity_field, coords - xOffset).y;
    float right = texture2D(velocity_field, coords + xOffset).y;
    float bottom = texture2D(velocity_field, coords - yOffset).x;
    float top = texture2D(velocity_field, coords + yOffset).x;

    vec4 vorticity = vec4(rHalfScale * (right - left - top + bottom), 0.0, 0.0, 1.0);
	
	gl_FragColor = vorticity;// * texture2D( gm_BaseTexture, v_vTexcoord );
}