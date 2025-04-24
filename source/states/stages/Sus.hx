package states.stages;

import states.stages.objects.*;
import objects.Character;

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

	// var singer:Character;
	// function target() {
	// 	if (game.gf != null && PlayState.SONG.notes[curSection].gfSection)
	// 		singer = gf;
	// 	else if (!PlayState.SONG.notes[curSection].mustHitSection)
	// 		singer = dad;
	// 	else
	// 		singer = boyfriend;
	// }

	// var offset:Float = 20;
	// override function update(elapsed:Float)
	// {
	// 	// Yay for targetOffset
	// 	camFollow.setPosition(980, 660);
	// 	target();
	// 	switch(singer.animation.curAnim.name){
	// 		case 'singLEFT':
	// 			camGame.targetOffset.x = -offset;
	// 			camGame.targetOffset.y = 0;
	// 		case 'singDOWN':
	// 			camGame.targetOffset.x = 0;
	// 			camGame.targetOffset.y = offset;
	// 		case 'singUP':
	// 			camGame.targetOffset.x = 0;
	// 			camGame.targetOffset.y = -offset;
	// 		case 'singRIGHT':
	// 			camGame.targetOffset.x = offset;
	// 			camGame.targetOffset.y = 0;
	// 		default: // For anything that isn't singing, like idle
	// 			camGame.targetOffset.x = 0;
	// 			camGame.targetOffset.y = 0;
	// 	}
	// }
	// Note: Originals made by stilic_dev, Blue (bluecolorsin), and Pumpsuki
}