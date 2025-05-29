package states.stages;

import states.stages.objects.*;

class Bridge extends BaseStage
{
	// If you're moving your stage from PlayState to a stage file,
	// you might have to rename some variables if they're missing, for example: camZooming -> game.camZooming

	var crowd:BGSprite;
	override function create()
	{
		// Spawn your stage sprites here.
		// Characters are not ready yet on this function, so you can't add things above them yet.
		// Use createPost() if that's what you want to do.
		var bg:BGSprite = new BGSprite('background', -900, -1200);
		add(bg);
		var bridge:BGSprite = new BGSprite('bridge', -900, -730);
		add(bridge);
		var fg:BGSprite = new BGSprite('foreground', -900, 2133);
		add(fg);
		crowd = new BGSprite('AceCrowd', -210, -70, ['jam']);
		crowd.animation.addByPrefix('bop', 'jam', 24, false);
		add(crowd);
	}

	override function createPost() 
	{
		// Use this function to layer things above characters!
		gf.scrollFactor.set(1.0, 1.0); // She kept moving
	}

	override function beatHit()
	{
		// Code here
		if(curBeat % 2 == 0)
            crowd.animation.play("bop", true);
	}
}