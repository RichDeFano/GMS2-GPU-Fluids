//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform vec2 size;
uniform float rHalfScale;
uniform float timestep;
uniform float epsilon;
uniform vec2 curl;

uniform sampler2D velocity_field;
uniform sampler2D vorticity_field;

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

float getScalarFromTexture(vec4 colorValues){
	float newScalar = (colorValues.x) + (colorValues.y / 255.0);
	newScalar = (newScalar * 10.0);
	return newScalar;
}



void main() {
    vec2 coords = gl_FragCoord.xy / size.xy;
	vec2 xOffset = vec2(1.0 / size.x, 0.0);
    vec2 yOffset = vec2(0.0, 1.0 / size.y);

    float left = getScalarFromTexture(texture2D(vorticity_field, coords - xOffset));//y
    float right = getScalarFromTexture(texture2D(vorticity_field, coords + xOffset));//y
    float bottom = getScalarFromTexture(texture2D(vorticity_field, coords - yOffset));//x
    float top = getScalarFromTexture(texture2D(vorticity_field, coords + yOffset));//x

    float center = getScalarFromTexture(texture2D(vorticity_field, coords));//x;

    vec2 force = rHalfScale * vec2(abs(top) - abs(bottom), abs(right) - abs(left));
    float lengthSquared = max(epsilon, dot(force, force));

    force *= inversesqrt(lengthSquared) * curl * center;
    force.y *= -1.0;

    vec2 v = getVectorFromTexture(texture2D(velocity_field, coords)) + (timestep * force);
	gl_FragColor = setVectorToTexture(v);
}

