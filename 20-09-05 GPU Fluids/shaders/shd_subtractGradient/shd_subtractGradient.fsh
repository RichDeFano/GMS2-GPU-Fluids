/* Subtracts the gradient. */

//out vec2 color;

//uniform float rHalfScale;

uniform sampler2D pressure_field;
uniform sampler2D velocity_field;
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

float unpack_ufloat_16(vec2 data) {return data.x + (data.y / 255.0);}
vec2 pack_ufloat_16(float data) {return vec2(floor(data * 255.0) / 255.0, fract(data * 255.0));}

vec2 getVelocityFromTexture(vec4 colorValues){
	vec2 newVelocity = vec2(colorValues.xy + ((colorValues.zw)/255.0));
	newVelocity = (newVelocity - (128.0/255.0)) * 5.0;
	return newVelocity;
}


void main() {
    vec2 coords = vec2(gl_FragCoord.xy);

    // Get the pressures from our neighboring cells
    vec2 center = getVelocityFromTexture(texture2D(velocity_field, coords));
    float left = unpack_ufloat_16(texture2D(pressure_field, coords + vec2(-1, 0)).xy);
    float right = unpack_ufloat_16(texture2D(pressure_field, coords + vec2(1, 0)).xy);
    float bottom = unpack_ufloat_16(texture2D(pressure_field, coords + vec2(0, -1)).xy);
    float top = unpack_ufloat_16(texture2D(pressure_field, coords + vec2(0, 1)).xy);

    vec2 color = center - 0.5 * vec2(right - left, top - bottom);
	
	gl_FragColor = vec4(color,0.0,0.0);// * texture2D( gm_BaseTexture, v_vTexcoord );
}