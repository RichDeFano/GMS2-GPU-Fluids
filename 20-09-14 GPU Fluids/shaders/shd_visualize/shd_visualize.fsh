//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform vec3 bias;
uniform vec2 scale;
uniform float maxVal;

uniform float alph;
uniform bool isVector;
uniform bool isNegative;
uniform sampler2D vector_field;

///////////////////////////////////////////////////////////////////////////////////////////
#define VECTOR_RANGE 10.0
#define SCALAR_RANGE 10.0
vec2 getVectorFromTexture(vec4 colorValues){
	vec2 newVector = vec2(colorValues.x - 128.0,colorValues.y - 128.0);
	newVector = (newVector/128.0) * VECTOR_RANGE;
	return newVector;
}

vec4 setVectorToTexture(vec2 vector){
	vec2 normalizedVector = ((vector/VECTOR_RANGE) * (128.0)) + 128.0;
	vec4 newVTexture = vec4(normalizedVector,0.0,1.0);
	return newVTexture;
}

float getScalarFromTextureUnsigned(vec4 colorValues){
	float newScalar = (colorValues.x)/255.0;
	newScalar = (newScalar * SCALAR_RANGE);
	return newScalar;
}

vec4 setScalarToTextureUnsigned(float scalar){
	float normalizedScalar = (scalar/SCALAR_RANGE) * 255.0;
	vec4 newSTexture = vec4(normalizedScalar,0.0,0.0,1.0);
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
	float mag = sqrt((vel.x*vel.x)+(vel.y*vel.y))/14.5;
	return mag;
}

float gauss(vec2 p, float r) {
    return exp(-dot(p, p) / r);
}

////////////////////////////////////////////////////////////

void main() {
	
	vec2 coords = gl_FragCoord.xy;
	vec4 white = vec4(255.0,255.0,255.0,0.0);
	float scalar;
	if (isNegative)
	{scalar = getScalarFromTextureSigned(texture2D(vector_field,coords));}
	else
	{scalar = getScalarFromTextureUnsigned(texture2D(vector_field,coords));}
	
	vec2 vector = getVectorFromTexture(texture2D(vector_field,coords));
	scalar = scalar/10.0;
	float vecMag = (vector.x + vector.y)/20.0;
	
	if (!isVector)
	{white.a = scalar;}
	else
	{white.a = vecMag;}
	
	gl_FragColor = white * texture2D(vector_field,coords);
	
}
	/*
	float scalar;
	if (isNegative)
	{scalar = getScalarFromTextureS(texture2D(vector_field,scale * coords));}
	else
	{scalar = getScalarFromTextureU(texture2D(vector_field,scale * coords));}
	vec2 vector = getVectorFromTexture(texture2D(vector_field,scale * coords));
	scalar = scalar/10.0;
	float vecMag = (vector.x + vector.y)/20.0;
	
	vec4 red = vec4(255.0,0.0,0.0,scalar);
	vec4 yellow = vec4(0.0,255.0,0.0,vecMag);
	vec4 blue = vec4(0.0,0.0,255.0,scalar);
	
	if (isVector == false)
   {
	if (isNegative)
	{gl_FragColor = (blue);}
	else
    {gl_FragColor = (red);}// + vec4(0.0,0.0,0.0,scalar));}// * texture2D(gm_BaseTexture,v_vTexcoord);}
   }
   else
   {gl_FragColor = (yellow);}//+ vec4(0.0,0.0,0.0,vecMag));}// * texture2D(gm_BaseTexture,v_vTexcoord);}

}*/