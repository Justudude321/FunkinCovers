package states.stages;

import states.stages.objects.*;
import objects.Character;

class Rivalarena extends BaseStage
{
	// If you're moving your stage from PlayState to a stage file,
	// you might have to rename some variables if they're missing, for example: camZooming -> game.camZooming

	override function create()
	{
		// Spawn your stage sprites here.
		// Characters are not ready yet on this function, so you can't add things above them yet.
		// Use createPost() if that's what you want to do.
		var bg:BGSprite = new BGSprite('Bg', -75, 200);
		bg.setGraphicSize(Std.int(bg.width*0.5),Std.int(bg.height*0.5));
		bg.updateHitbox();
		add(bg);
	}
	
	override function createPost()
	{
		// Use this function to layer things above characters!
		var table:BGSprite = new BGSprite('Table', 1130, 200);
		table.setGraphicSize(Std.int(table.width*0.5),Std.int(table.height*0.5));
		table.updateHitbox();
		add(table);
	}

	var singer:Character;
	function target() {
		if (game.gf != null && PlayState.SONG.notes[curSection].gfSection)
			singer = game.gf;
		else if (!PlayState.SONG.notes[curSection].mustHitSection)
			singer = game.dad;
		else
			singer = game.boyfriend;
	}

	var offset:Float = 20;
	override function update(elapsed:Float)
	{
		target();
		switch(singer.animation.curAnim.name){
			case 'singLEFT':
				game.camGame.targetOffset.x = -offset;
				game.camGame.targetOffset.y = 0;
			case 'singDOWN':
				game.camGame.targetOffset.x = 0;
				game.camGame.targetOffset.y = offset;
			case 'singUP':
				game.camGame.targetOffset.x = 0;
				game.camGame.targetOffset.y = -offset;
			case 'singRIGHT':
				game.camGame.targetOffset.x = offset;
				game.camGame.targetOffset.y = 0;
			default://For anything that isn't singing, like idle
				game.camGame.targetOffset.x = 0;
				game.camGame.targetOffset.y = 0;
		}
	}
}