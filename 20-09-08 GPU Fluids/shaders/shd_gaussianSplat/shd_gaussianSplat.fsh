//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;


uniform vec2 point;
uniform float radius;
uniform vec3 fillColor;

uniform sampler2D scalar_field;


float gauss(vec2 p, float r) {
    return exp(-dot(p, p) / r);
}



float getScalarFromTextureUnsigned(vec4 colorValues){
	float newScalar = (colorValues.x)/255.0;
	newScalar = (newScalar * 10.0);
	return newScalar;
}

vec4 setScalarToTextureUnsigned(float scalar,float mag){
	float normalizedScalar = (scalar/10.0) * 255.0;
	vec4 newSTexture = vec4(normalizedScalar,0.0,0.0,mag);
	return newSTexture;
}



void main() {
	
	
	vec2 coords = vec2(gl_FragCoord.xy);
    vec4 sourceColor = texture2D(scalar_field, coords);
	vec4 color;
	color = vec4(mix(sourceColor.xyz, fillColor, gauss(point - coords, radius)), gauss(point - coords, radius));
	
	// vec4 color = vec4(mix(sourceColor.xyz, fillColor, gauss(point - coords, radius)), sourceColor.w+0.5);
	gl_FragColor = color;// * texture2D( vector_field,coords );
}
	/*
	vec2 coords = vec2(gl_FragCoord.xy);
    float sourceColor = getScalarFromTextureUnsigned(texture2D(scalar_field, coords));
	if (distance(point,coords) < radius)
	{
		sourceColor = 10.0;//mix(sourceColor,fillColor,gauss(point - coords, radius));}\
		gl_FragColor = setScalarToTextureUnsigned(sourceColor,1.0);
	}
	else
	{
	gl_FragColor = setScalarToTextureUnsigned(sourceColor,0.0);
	}

}*/