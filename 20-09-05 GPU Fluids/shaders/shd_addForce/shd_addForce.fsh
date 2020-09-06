//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;


uniform vec2 point;
uniform float radius;
uniform vec3 fillColor;

uniform sampler2D vector_field;



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



float gauss(vec2 p, float r) {
    return exp(-dot(p, p) / r);
}


void main()
{
	vec2 coords = gl_FragCoord.xy;
	
    gl_FragColor = v_vColour * texture2D( gm_BaseTexture, v_vTexcoord );
}
