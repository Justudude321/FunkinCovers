package states.stages;

import states.stages.objects.*;

class Santa extends BaseStage
{
	// If you're moving your stage from PlayState to a stage file,
	// you might have to rename some variables if they're missing, for example: camZooming -> game.camZooming

	var holiBG:BGSprite;
	var eyes:BGSprite;
	override function create()
	{
		// Spawn your stage sprites here.
		// Characters are not ready yet on this function, so you can't add things above them yet.
		// Use createPost() if that's what you want to do.
		holiBG = new BGSprite('BG', -203, -309);
		add(holiBG);
		eyes = new BGSprite('eyes', 400, 204);
		add(eyes);
		eyes.alpha = 0;
		insert(2, dadGroup);
	}

	override function createPost()
	{
		// Use this function to layer things above characters!
		gf.scrollFactor.set(1,1);
	}

	// Steps, Beats and Sections:
	//    curStep, curDecStep
	//    curBeat, curDecBeat
	//    curSection
	override function beatHit()
	{
		// Code here
		if(curBeat == 204){
			FlxTween.tween(eyes, {alpha: 1}, 1);
			FlxTween.tween(holiBG, {alpha: 0.5}, 1);
		}
	}
}