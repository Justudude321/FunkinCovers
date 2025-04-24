package states.stages;

import states.stages.objects.*;
import shaders.DropShadowScreenspace;

class Hall extends BaseStage
{
	// If you're moving your stage from PlayState to a stage file,
	// you might have to rename some variables if they're missing, for example: camZooming -> game.camZooming

	override function create()
	{
		// Spawn your stage sprites here.
		// Characters are not ready yet on this function, so you can't add things above them yet.
		// Use createPost() if that's what you want to do.
		var bg:BGSprite = new BGSprite('NikusaBG', -1000, -425);
		add(bg);
	}

	var shadow:DropShadowScreenspace;
	override function createPost()
	{
		// Use this function to layer things above characters!
		// 180 = LEFT | 0 = RIGHT, linear burn of a shade of blue 
		// overlay, 2 different drop shadows... color dodge
		shadow = new DropShadowScreenspace();
		boyfriend.shader = shadow;
		shadow.doubleRim = true;
		shadow.angle = 180;
		shadow.angle2 = 0;
		shadow.strength = 0.88;
		shadow.distance = 15; // adjust accordingly
		shadow.threshold = 0.1;
		shadow.color = 0xffac8eff;//0xffac8eff, 0xff9069fd, 0xff6b69fd
		shadow.setAdjustColor(-115.1, -15, -20, 13.7);

		for(i in 0...unspawnNotes.length)
			unspawnNotes[i].changeRGB('entity');
		for(i in 0...game.strumLineNotes.length)
			game.strumLineNotes.members[i].strumRGB('entity');
		
		game.oppHitDrain = true;
		game.drainAmount = 0.018;
	}
}