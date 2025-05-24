package shaders;

import flixel.system.FlxAssets.FlxShader;

//Lullaby, Richard (Orva Courses) videos help!
class Wavy extends FlxShader
{
	@:glFragmentSource('
	#pragma header
	uniform float iTime;
	uniform float wavy;

	void main()
	{
		vec2 uv = openfl_TextureCoordv.xy;
		uv.x += sin((uv.y + iTime * 0.05) * wavy) * 0.05;
		gl_FragColor = flixel_texture2D(bitmap, uv);
	}
	')
	public function new()
	{
		super();
		this.iTime.value = [0.0];
		this.wavy.value = [0.0]; // Default strength
	}
}