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
		PlayState.instance.introSoundsSuffix = "-hotline";
	}

	override function update(elapsed:Float)
	{
		// Might need to change this...
		game.camFollow.setPosition(980, 660);
	}

	// override function startCountdown():Bool {
	// 	return super.startCountdown();
	// }

	// override function countdownTick(count:Countdown, num:Int)
	// {
	// 	switch(count)
	// 	{
	// 		case THREE: //num 0
	// 		Paths.sound('intro3-hotline');
	// 		case TWO: //num 1
	// 		Paths.sound('intro2-hotline');
	// 		case ONE: //num 2
	// 		Paths.sound('intro1-hotline');
	// 		case GO: //num 3
	// 		Paths.sound('introGo-hotline');
	// 		case START: //num 4
	// 	}
	// }
	
	// Might attempt to do camfollow note press here, idk
	// Note Hit/Miss
	override function goodNoteHit(note:objects.Note)
	{
		// Code here
	}

	override function opponentNoteHit(note:objects.Note)
	{
		// Code here
	}

	override function noteMiss(note:objects.Note)
	{
		// Code here
	}

	override function noteMissPress(direction:Int)
	{
		// Code here
	}
}