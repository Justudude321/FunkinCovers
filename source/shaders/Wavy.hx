package shaders;

import flixel.system.FlxAssets.FlxShader;

//Lullaby, Richard (Orva Courses) videos help!
class Wavy extends FlxShader
{
	@:glFragmentSource('
	#pragma header
	vec2 uv = openfl_TextureCoordv.xy;
	vec2 fragCoord = openfl_TextureCoordv*openfl_TextureSize;
	vec2 iResolution = openfl_TextureSize;
	uniform float iTime;
	#define iChannel0 bitmap
	#define texture flixel_texture2D
	#define fragColor gl_FragColor
	#define mainImage main
	uniform float wavy = 8.0;
	void main()
	{
		vec2 uv = fragCoord.xy / iResolution.xy;
		uv.x += (sin((uv.y + (iTime * 0.05)) * wavy) * 0.1) + 
			(sin((uv.y + (iTime * 0.8)) * 1.0) * 0.00001);
		vec4 texColor = texture(iChannel0, uv);
		fragColor = texColor;
	}
	')
	public function new()
	{
		super();
		this.iTime.value = [0.0];
		this.wavy.value = [0.0];
	}
}