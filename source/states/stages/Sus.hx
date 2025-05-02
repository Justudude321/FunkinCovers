package states.stages;

import states.stages.objects.*;

class Sus extends BaseStage
{
	// If you're moving your stage from PlayState to a stage file,
	// you might have to rename some variables if they're missing, for example: camZooming -> game.camZooming

	override function create()
	{
		// Spawn your stage sprites here.
		// Characters are not ready yet on this function, so you can't add things above them yet.
		// Use createPost() if that's what you want to do.
		var bg:BGSprite = new BGSprite('SUS', -10, 5);
		add(bg);
	}

	override function update(elapsed:Float)
	{
		camFollow.setPosition(980, 660);
	}
}