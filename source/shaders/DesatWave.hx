package shaders;

import flixel.system.FlxAssets.FlxShader;

// Lullaby, Richard (Orva Courses) videos help!
class DesatWave extends FlxShader
{
    @:glFragmentSource('
    #pragma header

    uniform float time;
    uniform float intensity;
    uniform float desat;

    void main()
    {
        vec2 uv = openfl_TextureCoordv;

        // Constants pulled out to avoid repeated ops
        float wave = sin(uv.y * 10.0 + time * 2.0);
        uv.x += wave * (0.005 * intensity);

        vec4 tex = texture2D(bitmap, uv);

        // Inline grayscale conversion (dot product)
        float lum = dot(tex.rgb, vec3(0.299, 0.587, 0.114));
        vec3 grayscale = vec3(lum);

        // Final mix
        vec3 finalColor = mix(tex.rgb, grayscale, desat);
        gl_FragColor = vec4(finalColor, tex.a);
    }
    ')
    public function new()
    {
        super();
        this.time.value = [0.0];
        this.intensity.value = [0.0]; // Wave distortion strength
        this.desat.value = [0.0];     // 0 = color, 1 = grayscale
    }
}
