package states.stages;

import states.stages.objects.*;

class Leafstorm extends BaseStage
{
	// If you're moving your stage from PlayState to a stage file,
	// you might have to rename some variables if they're missing, for example: camZooming -> game.camZooming

	override function create()
	{
		// Spawn your stage sprites here.
		// Characters are not ready yet on this function, so you can't add things above them yet.
		// Use createPost() if that's what you want to do.
		var farbg:BGSprite = new BGSprite('farbg', -350, 0, 0.1, 1.1);
		add(farbg);
		var closebg:BGSprite = new BGSprite('closebg', 225, -100, 0.6, 0.9);
		add(closebg);
		var closebg2:BGSprite = new BGSprite('closebg2', -270, 520, 0.7, 0.9);
		add(closebg2);
		var gfplatform:BGSprite = new BGSprite('gfplatform', 1270, 520, 0.7, 0.9);
		add(gfplatform);			
		var bgrings:BGSprite = new BGSprite('bgrings', -200, 220, 0.7, 0.9, ['rings'], true);
		add(bgrings);
		var fgfloor:BGSprite = new BGSprite('fgfloor', -500, 720);
		add(fgfloor);

		game.introSoundsSuffix = "-rush";
	}

	override function createPost() 
	{
		// Use this function to layer things above characters!
		gf.scrollFactor.set(0.7, 0.9);
		gf.setGraphicSize(Std.int(gf.width * 0.7), Std.int(gf.height * 0.7));
	}
}