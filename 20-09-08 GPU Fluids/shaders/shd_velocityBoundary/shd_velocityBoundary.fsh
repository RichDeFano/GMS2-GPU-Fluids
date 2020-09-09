//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;


uniform int width;
uniform int height;

uniform sampler2D vector_field; // either the velocity or pressure field


vec2 getVectorFromTexture(vec4 colorValues){
	vec2 newVector = vec2(colorValues.x - 128.0,colorValues.y - 128.0);
	newVector = (newVector/255.0) * 10.0;
	return newVector;
}

vec4 setVectorToTexture(vec2 vector){
	vec2 normalizedVector = ((vector/10.0) + (128.0))/255.0;
	vec4 newVTexture = vec4(normalizedVector,0.0,0.0);
	return newVTexture;
}


void main() {
    ivec2 coords = ivec2(gl_FragCoord.xy);
    int x = coords.x;
    int y = coords.y;

vec2 bounded = vec2(0.0,0.0);
    if (x == 0 || x == width - 1 || y == 0 || y == height - 1) { // At a boundary
        bounded = getVectorFromTexture(vec4(128.0,128.0,0.0,0.0));
    } else {
        bounded = getVectorFromTexture(texture2D(vector_field, vec2(coords)) );
    }
	
	gl_FragColor = setVectorToTexture(bounded);// * texture2D( gm_BaseTexture, v_vTexcoord );
}
	
