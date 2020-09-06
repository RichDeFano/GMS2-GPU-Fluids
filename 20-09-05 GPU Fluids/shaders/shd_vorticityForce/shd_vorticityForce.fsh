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

float getCurlFromTexture(float curlValues){
	float newCurl = float(curlValues);
	newCurl = (newCurl - (128.0/255.0)) * 5.0;
	return newCurl;
}

float unpack_ufloat_16(vec2 data) {return data.x + (data.y / 255.0);}

vec2 getVelocityFromTexture(vec4 colorValues){
	vec2 newVelocity = vec2(colorValues.xy + ((colorValues.zw)/255.0));
	newVelocity = (newVelocity - (128.0/255.0)) * 5.0;
	return newVelocity;
}

void main() {
    vec2 coords = gl_FragCoord.xy / size.xy;

    vec2 xOffset = vec2(1.0 / size.x, 0.0);
    vec2 yOffset = vec2(0.0, 1.0 / size.y);

    float left = getCurlFromTexture(texture2D(vorticity_field, coords - xOffset).y);//y
    float right = getCurlFromTexture(texture2D(vorticity_field, coords + xOffset).y);//y
    float bottom = getCurlFromTexture(texture2D(vorticity_field, coords - yOffset).x);//x
    float top = getCurlFromTexture(texture2D(vorticity_field, coords + yOffset).x);//x

    float center = getCurlFromTexture(texture2D(vorticity_field, coords).x);//x;

    vec2 force = rHalfScale * vec2(abs(top) - abs(bottom), abs(right) - abs(left));
    float lengthSquared = max(epsilon, dot(force, force));

    force *= inversesqrt(lengthSquared) * curl * center;
    force.y *= -1.0;

    vec2 v = getVelocityFromTexture(texture2D(velocity_field, coords));
    vec4 newVelocity = vec4(v + (timestep * force), 0.0, 1.0);
	//gl_FragColor = newVelocity;// * texture2D( gm_BaseTexture, v_vTexcoord );
	
	gl_FragColor = newVelocity * texture2D( velocity_field, coords ); //* texture2D( advected_field, pos);
}

