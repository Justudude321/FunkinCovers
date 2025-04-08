package states.stages;

// import shaders.DropShadowShader;
import states.stages.objects.*;
import shaders.Sunset;

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
	
	// var shadow:DropShadowShader;
	override function createPost()
	{
		// Use this function to layer things above characters!
		boyfriend.shader = new Sunset();

		// shadow = new DropShadowShader();
		// boyfriend.shader = shadow; // H = 350, S = 74, B = 22
		// shadow.angle = 45;
		// shadow.setAdjustColor(-66, -23, 5, 25);// b,h,c,s | -66, -23, 5, 25
		// shadow.set
	}
}