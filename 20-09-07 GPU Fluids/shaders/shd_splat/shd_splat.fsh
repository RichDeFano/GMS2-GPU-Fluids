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
	vec2 newVector = vec2(colorValues.xy + ((colorValues.zw)/255.0));
	newVector = (newVector - (128.0/255.0)) * 10.0;
	return newVector;
}

vec4 setVectorToTexture(vec2 vector){
	vec2 normalizedVector = (vector/10.0) + (128.0/255.0);
	vec4 newVTexture = vec4(normalizedVector,0.0,0.0);
	return newVTexture;
}

void main() {
	
     vec2 coords = vec2(gl_FragCoord.xy);
    vec4 sourceColor = texture2D(vector_field, coords);
	vec4 color;
    if (distance(coords, point) < radius) {
        color = vec4(fillColor, gauss(coords,radius));
    } else {
        color = sourceColor;
    }
	
	gl_FragColor = color;// * texture2D( gm_BaseTexture, v_vTexcoord );
	/*
	vec2 coords = vec2(gl_FragCoord.xy);
    vec4 sourceColor = texture2D(vector_field,coords);

    gl_FragColor = vec4(mix(sourceColor.xyz, fillColor, gauss(point - coords, radius)), 1.0);
	/*
    vec2 coords = vec2(gl_FragCoord.xy);
    vec2 sourceVector = getVectorFromTexture(texture2D(vector_field, coords));
	if (distance(coords, point) > radius) {
		vec4 color = vec4(255.0,255.0,0.0,gauss(point - coords,radius));
		gl_FragColor = color;
		//vec2 colorVel = getVectorFromTexture(color);	
		//sourceVector = sourceVector + colorVel;
	}
	gl_FragColor = setVectorToTexture(sourceVector);
	*/
}