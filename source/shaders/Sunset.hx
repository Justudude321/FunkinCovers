package shaders;

// Allegro, took the frag shader from https://gamebanana.com/mods/447889
// Converted it to haxe
import flixel.system.FlxAssets.FlxShader;

class Sunset extends FlxShader
{
	@:glFragmentSource('
	#pragma header

	uniform float redMultiplier = 0.22;
	uniform float greenMultiplier = 0.066;
	uniform float blueMultiplier = 0.086;
	
	void main() {
		vec4 color = flixel_texture2D(bitmap, openfl_TextureCoordv);
		color.rgb = (color.rgb + vec3(redMultiplier, greenMultiplier, blueMultiplier)) * .6 * color.a;
		gl_FragColor = color;
	}
	')
	public function new()
	{
		super();
	}
}
