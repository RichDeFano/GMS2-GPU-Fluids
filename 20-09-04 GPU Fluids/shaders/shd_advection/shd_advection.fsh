//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform vec2 rSize;
uniform float rScale;
uniform float timestep;
uniform float dissipation;

uniform sampler2D velocity_field;
uniform sampler2D advected_field;

void main()
{
	vec2 coords = gl_FragCoord.xy;
	vec2 pos = rSize * (coords - timestep * rScale * texture2D(velocity_field, rSize * coords).xy);
	vec4 color = dissipation * texture2D( advected_field, coords );
	gl_FragColor = color;// * texture2D( gm_BaseTexture, coords );
}
