package shaders;

// 7quid, changed slightly
import flixel.system.FlxAssets.FlxShader;

class Static extends FlxShader
{
	@:glFragmentSource('
	#pragma header

	uniform float u_elapsed = 0;
	uniform float u_alpha = 1;

	float random(vec2 coord) {
		return fract(sin(dot(coord, vec2(12.9898, 78.233))) * 43758.5453);
	}

	void main() {
		vec2 uv = openfl_TextureCoordv.xy;

		float t = floor(mod(u_elapsed, 1.0) * 24.0);
		float noiseVal = random(uv + t);
		vec4 color = flixel_texture2D(bitmap, uv);
		vec3 noise = vec3(noiseVal);

		vec4 staticColor = vec4(color.rgb * (1.0 - noise * (1.0 - color.rgb)), color.a);
		gl_FragColor = mix(color, staticColor, u_alpha);
	}
	')
	public function new()
	{
		super();
	}
}