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
		// Returns 0.0 or 1.0 based on 2x2 Bayer matrix
		return dither_2[int(mod(coord.x, 2.0))][int(mod(coord.y, 2.0))];
	}

	int closest_index(vec3 color) {
		float minDist = 1000.0;
		int idx = 0;
		for (int i = 0; i < 4; i++) {
			float d = distance(color, gb_colors[i]);
			if (d < minDist) {
				minDist = d;
				idx = i;
			}
		}
		return idx;
	}

	vec3 closest_gb(vec3 color) {
		return gb_colors[closest_index(color)];
	}

	void two_closest(vec3 color, out int firstIdx, out int secondIdx) {
		float dists[4];
		for (int i = 0; i < 4; i++) {
			dists[i] = distance(color, gb_colors[i]);
		}
		firstIdx = 0;
		secondIdx = 1;
		if (dists[1] < dists[0]) {
			firstIdx = 1;
			secondIdx = 0;
		}
		for (int i = 2; i < 4; i++) {
			if (dists[i] < dists[firstIdx]) {
				secondIdx = firstIdx;
				firstIdx = i;
			} else if (dists[i] < dists[secondIdx]) {
				secondIdx = i;
			}
		}
	}

	bool needs_dither(vec3 color) {
		int i1, i2;
		two_closest(color, i1, i2);
		float d1 = distance(color, gb_colors[i1]);
		float d2 = distance(color, gb_colors[i2]);
		return abs(d1 - d2) <= threshold;
	}

	vec3 get_dithered_color(vec3 color, vec2 coord) {
		int i1, i2;
		two_closest(color, i1, i2);
		float d = get_dither(coord);
		return (d < 0.5) ? gb_colors[i1] : gb_colors[i2];
	}

	void main() {
		vec4 sample = texture2D(bitmap, openfl_TextureCoordv);
		if (sample.a == 0.0) {
			gl_FragColor = vec4(0.0);
			return;
		}

		vec3 color = sample.rgb;
		vec3 finalColor;

		// Apply overrides
		if (all(equal(color, buried_eye_color)) ||
			all(equal(color, buried_grave_color)) ||
			all(equal(color, buried_wall_color))) {
			finalColor = gb_colors[2];
		} else if (needs_dither(color)) {
			finalColor = get_dithered_color(color, gl_FragCoord.xy);
		} else {
			finalColor = closest_gb(color);
		}

		gl_FragColor = vec4(mix(color * sample.a, finalColor, intensity), sample.a);
	}
	')
	public function new()
	{
		super();
		this.intensity.value = [0.0];
	}
}