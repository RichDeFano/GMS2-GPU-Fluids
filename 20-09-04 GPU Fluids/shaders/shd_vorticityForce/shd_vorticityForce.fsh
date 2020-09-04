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


void main() {
    vec2 coords = gl_FragCoord.xy / size.xy;

    vec2 xOffset = vec2(1.0 / size.x, 0.0);
    vec2 yOffset = vec2(0.0, 1.0 / size.y);

    float left = texture2D(vorticity_field, coords - xOffset).x;
    float right = texture2D(vorticity_field, coords + xOffset).x;
    float bottom = texture2D(vorticity_field, coords - yOffset).x;
    float top = texture2D(vorticity_field, coords + yOffset).x;
    float center = texture2D(vorticity_field, coords).x;

    vec2 force = rHalfScale * vec2(abs(top) - abs(bottom), abs(right) - abs(left));
    float lengthSquared = max(epsilon, dot(force, force));

    force *= inversesqrt(lengthSquared) * curl * center;
    force.y *= -1.0;

    vec2 v = texture2D(velocity_field, coords).xy;
    vec4 newVelocity = vec4(v + (timestep * force), 0.0, 1.0);
	gl_FragColor = newVelocity;// * texture2D( gm_BaseTexture, v_vTexcoord );
}