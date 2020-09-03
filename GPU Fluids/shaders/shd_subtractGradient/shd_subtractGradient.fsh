/* Subtracts the gradient. */

//out vec2 color;

//uniform float rHalfScale;

uniform sampler2D pressure_field;
uniform sampler2D velocity_field;
varying vec2 v_vTexcoord;
varying vec4 v_vColour;



void main() {
    vec2 coords = vec2(gl_FragCoord.xy);

    // Get the pressures from our neighboring cells
    vec2 center = texture2D(velocity_field, coords).xy;
    float left = texture2D(pressure_field, coords + vec2(-1, 0)).x;
    float right = texture2D(pressure_field, coords + vec2(1, 0)).x;
    float bottom = texture2D(pressure_field, coords + vec2(0, -1)).x;
    float top = texture2D(pressure_field, coords + vec2(0, 1)).x;

    vec2 color = center - 0.5 * vec2(right - left, top - bottom);
	
	gl_FragColor = vec4(color,0.0,0.0) * texture2D( gm_BaseTexture, v_vTexcoord );
}