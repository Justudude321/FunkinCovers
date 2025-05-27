package shaders;

import flixel.system.FlxAssets.FlxShader;

// Lullaby, Richard (Orva Courses) videos help!
// It pulses and stuff... used for brimstone
class Vignette extends FlxShader
{
    @:glFragmentSource('
    #pragma header

    uniform float time;
    uniform float intenMin;
    uniform float intenGain;
    uniform vec3 color;

    void main()
    {
        vec2 uv = openfl_TextureCoordv;
        vec4 texColor = texture2D(bitmap, uv);

        // Precompute sin modulation only once
        float pulse = intenMin + intenGain * sin(time * 3.14159265);

        // Dot product for distance approximation
        vec2 offset = uv - 0.5;
        float vignette = dot(offset, offset); // Square of distance (0 to 0.5^2)

        // Scale to [0.0, 1.0] range and apply pulse
        vignette = mix(1.0, 1.0 - pulse, clamp(vignette * 4.0, 0.0, 1.0));

        // Blend the tint and base color
        vec3 finalColor = mix(color, texColor.rgb, vignette);

        // Alpha can still be used if you want a transparency pulsing effect
        gl_FragColor = vec4(finalColor, 1.0 - vignette);
    }
    ')
    public function new()
    {
        super();
        this.time.value = [0.0];
        this.intenMin.value = [0.0];
        this.intenGain.value = [1.0]; 		// Do math so the max is never over 1
        this.color.value = [1.0, 0.0, 0.0]; // Red by default
    }
}