package shaders;

import flixel.system.FlxAssets.FlxShader;

// For brimstone, also has a gameboy shader
// Optimized ig... idk
class BrimCam extends FlxShader
{
	@:glFragmentSource('
	#pragma header

	uniform float intensity = 0.0;
	const float threshold = 0.125;

	const vec3 gb_colors[4] = vec3[4](
		vec3(8., 24., 32.) / 255.0,
		vec3(52., 104., 86.) / 255.0,
		vec3(136., 192., 112.) / 255.0,
		vec3(224., 248., 208.) / 255.0
	);

	const vec3 buried_eye_color = vec3(255.0, 0.0, 0.0) / 255.0;
	const vec3 buried_grave_color = vec3(121.0, 133.0, 142.0) / 255.0;
	const vec3 buried_wall_color = vec3(107., 130., 149.) / 255.0;

	mat2 dither_2 = mat2(0.0, 1.0, 1.0, 0.0);

	float get_dither(vec2 coord) {
		return dither_2[int(mod(coord.x, 2.0))][int(mod(coord.y, 2.0))];
	}

	void main() {
		vec4 sample = texture2D(bitmap, openfl_TextureCoordv);
		if (sample.a == 0.0) {
			gl_FragColor = vec4(0.0);
			return;
		}

		vec3 color = sample.rgb;

		// Quick override for specific colors
		if (all(equal(color, buried_eye_color)) ||
			all(equal(color, buried_grave_color)) ||
			all(equal(color, buried_wall_color))) {
			vec3 overrideColor = gb_colors[2];
			gl_FragColor = vec4(mix(color, overrideColor, intensity), sample.a);
			return;
		}

		// Precompute distances to GB colors
		float d0 = distance(color, gb_colors[0]);
		float d1 = distance(color, gb_colors[1]);
		float d2 = distance(color, gb_colors[2]);
		float d3 = distance(color, gb_colors[3]);

		// Find two smallest distances (sorted)
		float min1 = d0, min2 = d1;
		int i1 = 0, i2 = 1;
		if (d1 < d0) {
			min1 = d1; min2 = d0; i1 = 1; i2 = 0;
		}
		if (d2 < min1) {
			min2 = min1; min1 = d2; i2 = i1; i1 = 2;
		} else if (d2 < min2) {
			min2 = d2; i2 = 2;
		}
		if (d3 < min1) {
			min2 = min1; min1 = d3; i2 = i1; i1 = 3;
		} else if (d3 < min2) {
			min2 = d3; i2 = 3;
		}

		vec3 finalColor;
		if (abs(min1 - min2) <= threshold) {
			// Dither between the two closest
			float d = get_dither(gl_FragCoord.xy);
			finalColor = (d < 0.5) ? gb_colors[i1] : gb_colors[i2];
		} else {
			finalColor = gb_colors[i1];
		}

		gl_FragColor = vec4(mix(color, finalColor, intensity), sample.a);
	}
	')
	public function new()
	{
		super();
		this.intensity.value = [0.0];
	}
}