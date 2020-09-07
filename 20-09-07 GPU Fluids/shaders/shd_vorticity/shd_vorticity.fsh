//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;


uniform vec2 size;
uniform float rHalfScale;

uniform sampler2D velocity_field;

vec2 getVectorFromTexture(vec4 colorValues){
	vec2 newVector = vec2(colorValues.xy + ((colorValues.zw)/255.0));
	newVector = (newVector - (128.0/255.0)) * 10.0;
	return newVector;
}

vec4 setScalarToTexture(float scalar){
	float normalizedScalar = scalar/10.0;
	vec4 newSTexture = vec4(normalizedScalar,0.0,0.0,0.0);
	return newSTexture;
}

void main() {
    vec2 coords = gl_FragCoord.xy;// / size.xy;

    vec2 xOffset = vec2(1.0, 0.0);
    vec2 yOffset = vec2(0.0, 1.0);

    float left = getVectorFromTexture(texture2D(velocity_field, coords - xOffset)).y;//y
    float right = getVectorFromTexture(texture2D(velocity_field, coords + xOffset)).y;//y
    float bottom = getVectorFromTexture(texture2D(velocity_field, coords - yOffset)).x;//x
    float top = getVectorFromTexture(texture2D(velocity_field, coords + yOffset)).x;//x
	float temp = (right - left) - (top + bottom);
    vec4 vorticity = setScalarToTexture(temp);
	
	gl_FragColor = vorticity;
	//vorticity * texture2D( velocity_field, coords ); //* texture2D( advected_field, pos);
}