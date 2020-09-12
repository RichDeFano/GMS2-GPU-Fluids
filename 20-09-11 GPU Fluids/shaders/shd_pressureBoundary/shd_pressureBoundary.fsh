//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;


uniform int width;
uniform int height;

uniform sampler2D scalar_field; // either the velocity or pressure field

float getScalarFromTexture(vec4 colorValues){
	float newScalar = (colorValues.x) + (colorValues.y / 255.0);
	newScalar = (newScalar * 10.0);
	return newScalar;
}

vec4 setScalarToTexture(float scalar){
	float normalizedScalar = scalar/10.0;
	vec4 newSTexture = vec4(normalizedScalar,0.0,0.0,0.0);
	return newSTexture;
}



void main() {
    ivec2 coords = ivec2(gl_FragCoord.xy);
    int x = coords.x;
    int y = coords.y;

float bounded = 0.0;
    if (x == 0 || x == width - 1 || y == 0 || y == height - 1) { // At a boundary
        bounded = getScalarFromTexture(vec4(0.0,0.0,0.0,0.0));
    } else {
        bounded = getScalarFromTexture(texture2D(scalar_field, vec2(coords)) );
    }
	
	gl_FragColor = setScalarToTexture(bounded);// * texture2D( gm_BaseTexture, v_vTexcoord );
}
	
