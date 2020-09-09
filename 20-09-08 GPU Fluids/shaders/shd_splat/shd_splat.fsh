//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;


uniform vec2 point;
uniform float radius;
uniform vec3 fillColor;

uniform sampler2D vector_field;



float gauss(vec2 p, float r) {
    return exp(-dot(p, p) / r);
}

vec2 getVectorFromTexture(vec4 colorValues){
	vec2 newVector = vec2(colorValues.x - 128.0,colorValues.y - 128.0);
	newVector = (newVector/255.0) * 10.0;
	return newVector;
}

vec4 setVectorToTexture(vec2 vector,float mag){
	vec2 normalizedVector = ((vector/10.0) * 255.0) + 128.0;
	vec4 newVTexture = vec4(normalizedVector,0.0,1.0);
	return newVTexture;
}

float magnitude(vec2 inVec){
	return sqrt((inVec.x*inVec.x) + (inVec.y*inVec.y));
}

void main() {
	
	/*
	vec2 coords = vec2(gl_FragCoord.xy);
    vec2 sourceVec = getVectorFromTexture(texture2D(vector_field, coords));
	float mag = magnitude(sourceVec);
	if (distance(point,coords) < radius)
	{
		sourceVec = vec2(10.0,10.0);//mix(sourceColor,fillColor,gauss(point - coords, radius));}\
		gl_FragColor = setVectorToTexture(sourceVec,1.0);
	}
	else
	{
	gl_FragColor = setVectorToTexture(sourceVec,0.0);
	}
	
	*/
	vec2 coords = vec2(gl_FragCoord.xy);
    vec4 sourceColor = magnitude(getVectorFromTexture(texture2D(vector_field, coords)));
	vec4 color;
    if (distance(coords, point) < radius) {
        color = vec4(255.0,255.0,0.0, sourceColor));
    } else {
        color = getVectorFromTexture(texture2D(vector_field, coords)
    }
	
	gl_FragColor = color * texture2D( gm_BaseTexture, v_vTexcoord );

}
	

