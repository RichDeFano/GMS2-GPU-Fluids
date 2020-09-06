//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform float scaleA;
uniform float scaleB;

uniform sampler2D tex_field1;
uniform sampler2D tex_field2;



void main()
{
    vec2 coords = vec2(gl_FragCoord.xy);
    vec4 color = scaleA * texture2D(tex_field1, coords) + scaleB * texture2D(tex_field2, coords);
	gl_FragColor = color;// * texture2D( tex_field2, coords);
}
