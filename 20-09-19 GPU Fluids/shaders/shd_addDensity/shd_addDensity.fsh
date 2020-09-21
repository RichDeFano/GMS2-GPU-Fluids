//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

//uniform vec2 prevPoint;
//uniform float timestep;
uniform vec2 point;
uniform float radius;
uniform vec3 fillColor;

uniform vec2 size;
uniform float scale;

uniform sampler2D scalar_field;

///////////////////////////////////////////////////////////////////////////////////////////
#define VECTOR_RANGE 10.0
#define SCALAR_RANGE 10.0
vec2 getVectorFromTexture(vec4 colorValues){
	vec2 newVector = vec2(colorValues.x - 128.0,colorValues.y - 128.0);
	newVector = (newVector/128.0) * VECTOR_RANGE;
	return newVector;
}

vec4 setVectorToTexture(vec2 vector,float alpha){
	vec2 normalizedVector = ((vector/VECTOR_RANGE) * (128.0)) + 128.0;
	vec4 newVTexture = vec4(normalizedVector,0.0,alpha);
	return newVTexture;
}

float getScalarFromTextureUnsigned(vec4 colorValues){
	float newScalar = (colorValues.x)/255.0;
	newScalar = (newScalar * SCALAR_RANGE);
	return newScalar;
}

vec4 setScalarToTextureUnsigned(float scalar,float alpha){
	float normalizedScalar = (scalar/SCALAR_RANGE) * 255.0;
	vec4 newSTexture = vec4(normalizedScalar,0.0,0.0,alpha);
	return newSTexture;
}

float getScalarFromTextureSigned(vec4 colorValues){
	float newScalar = (colorValues.x - 128.0)/128.0;
	newScalar = (newScalar * SCALAR_RANGE);
	return newScalar;
}

vec4 setScalarToTextureSigned(float scalar){
	float normalizedScalar = ((scalar/SCALAR_RANGE) * (128.0)) + 128.0;
	vec4 newSTexture = vec4(normalizedScalar,0.0,0.0,1.0);
	return newSTexture;
}

float magnitude(vec2 vel){
	float mag = sqrt((vel.x*vel.x)+(vel.y*vel.y)) / (sqrt((VECTOR_RANGE*VECTOR_RANGE)+(VECTOR_RANGE*VECTOR_RANGE)));
	return mag;
}

float gauss(vec2 p, float r) {
    return exp(-dot(p, p) / r);
}

////////////////////////////////////////////////////////////


void main() {
	vec2 coords = vec2(gl_FragCoord.xy);
    vec4 sourceColor = texture2D(scalar_field, coords);
	vec4 newColor = sourceColor;
	if (distance(point,coords) < radius)
	{
	newColor = mix(sourceColor, vec4(SCALAR_RANGE,0.0,0.0,1.0),gauss((point-coords),radius));
	}
	//float mag = newColor/SCALAR_RANGE;

	gl_FragColor = newColor;
}	
	/*
    vec2 sourceColor = getVectorFromTexture(texture2D(vector_field, coords));
	vec2 color;
    if (distance(coords, point) < radius) {
        color = mix(sourceColor,vec2(10.0,10.0),gauss((point-coords),radius));
    } else {
        color = sourceColor;
    }
	
	if (point == coords)
	{gl_FragColor = setVectorToTexture(vec2(10.0,10.0));}
		else
	{gl_FragColor = texture2D(vector_field,coords);}
			/// * texture2D( gm_BaseTexture, v_vTexcoord );
	/*
	vec2 coords = gl_FragCoord.xy;
	vec2 oldVel = getVectorFromTexture(texture2D(vector_field,coords));
	vec2 newVel = vec2(mix(oldVel.xy,vec2(10.0,10.0),gauss((point-coords),radius)));
	gl_FragColor = setVectorToTexture(newVel);
	*/
	/*
    vec2 coords = vec2(gl_FragCoord.xy);
    vec4 sourceColor = texture2D(vector_field, coords);
	vec4 color;
    if (distance(coords, point) < radius) {
        color = vec4(fillColor, 0.5);
    } else {
        color = sourceColor;
    }
	
	gl_FragColor = color;// * texture2D( gm_BaseTexture, v_vTexcoord );
}
*/
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
