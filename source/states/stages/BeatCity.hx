package states.stages;

import states.stages.objects.*;
import shaders.DropShadowShader;

class BeatCity extends BaseStage
{
	// If you're moving your stage from PlayState to a stage file,
	// you might have to rename some variables if they're missing, for example: camZooming -> game.camZooming

	override function create()
	{
		// Spawn your stage sprites here.
		// Characters are not ready yet on this function, so you can't add things above them yet.
		// Use createPost() if that's what you want to do.
		var bg:BGSprite = new BGSprite('beatcity', 0, 0);
		add(bg);
	}
	
	var shadow:DropShadowShader;
	override function createPost()
	{
		// Use this function to layer things above characters!
		shadow = new DropShadowShader();
		boyfriend.shader = shadow;
		shadow.angle = 180;
		shadow.strength = 0.9;
		shadow.distance = 0;
		shadow.threshold = 0.1;
		shadow.color = 0x371116;
		shadow.setAdjustColor(-60, 0, -40, -10);
	}
}