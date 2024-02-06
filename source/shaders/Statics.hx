package shaders;

//7quid
import flixel.system.FlxAssets.FlxShader;

class Statics extends FlxShader
{
	@:glFragmentSource('
	#pragma header

	uniform float u_elapsed = 0;
	uniform float u_alpha = 1;
	
	float random(vec2 vec) {return fract(sin(dot(vec.xy, vec2(12.9898, 78.233))) * 43758.5453);}
	void main() {
		vec2 uv = openfl_TextureCoordv.xy;
		vec4 noise = vec4(vec3(random(uv.xy + floor(mod(u_elapsed, 1.0) * 24.0))), 1.0);
		vec4 color = flixel_texture2D(bitmap, uv);
		gl_FragColor = color * (1.0 - u_alpha) + u_alpha * (color * (1.0 - noise * (1.0 - color)));
	}
	')
	public function new()
	{
		super();
	}
}
