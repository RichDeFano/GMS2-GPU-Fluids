//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;


uniform vec2 size;
uniform float rHalfScale;

uniform sampler2D velocity_field;


vec2 getVelocityFromTexture(vec4 colorValues){
	vec2 newVelocity = vec2(colorValues.xy + ((colorValues.zw)/255.0));
	newVelocity = (newVelocity - (128.0/255.0)) * 5.0;
	return newVelocity;
}

vec4 getTextureFromVelocity(vec2 velocity){
	vec4 newColor = vec4( floor(velocity*255.0)/255.0,fract(velocity*255.0));
	newColor = ((newColor/5.0) + (128.0/255.0));
	return newColor;
}

float getCurlFromTexture(float curlValues){
	float newCurl = float(curlValues);
	newCurl = (newCurl - (128.0/255.0)) * 5.0;
	return newCurl;
}

void main() {
    vec2 coords = gl_FragCoord.xy / size.xy;

    vec2 xOffset = vec2(1.0 / size.x, 0.0);
    vec2 yOffset = vec2(0.0, 1.0 / size.y);

    float left = getCurlFromTexture(texture2D(velocity_field, coords - xOffset).y);//y
    float right = getCurlFromTexture(texture2D(velocity_field, coords + xOffset).y);//y
    float bottom = getCurlFromTexture(texture2D(velocity_field, coords - yOffset).x);//x
    float top = getCurlFromTexture(texture2D(velocity_field, coords + yOffset).x);//x

    vec4 vorticity = vec4(1.0 * ((right - left) - (top + bottom)),0.0, 0.0, 1.0);
	
	gl_FragColor = vorticity * texture2D( velocity_field, coords ); //* texture2D( advected_field, pos);
}