package states.stages;

import states.stages.objects.*;

class Jojo extends BaseStage
{
	// If you're moving your stage from PlayState to a stage file,
	// you might have to rename some variables if they're missing, for example: camZooming -> game.camZooming

	override function create()
	{
		// Spawn your stage sprites here.
		// Characters are not ready yet on this function, so you can't add things above them yet.
		// Use createPost() if that's what you want to do.
		var bg:BGSprite = new BGSprite('bg', -2860, -1925);
		bg.setGraphicSize(Std.int(bg.width * 2.15));
		bg.updateHitbox();
		var building:BGSprite = new BGSprite('building', -2860, -1466);
		building.setGraphicSize(Std.int(building.width * 2.15));
		building.updateHitbox();
		var floor:BGSprite = new BGSprite('ground', -2860, -230);
		floor.setGraphicSize(Std.int(floor.width * 2.15));
		floor.updateHitbox();
		var fg:BGSprite = new BGSprite('fg', -2850, -1975);
		fg.setGraphicSize(Std.int(1920 * 2.15));
		fg.updateHitbox();
		add(bg);
		add(building);
		add(floor);
		add(fg);
	}
	
	override function createPost()
	{
		// Use this function to layer things above characters!
		gf.scrollFactor.set(1,1);
	}

	var reset:Float = 0;
	override function update(elapsed:Float)
	{
		// Code here
		var frameLerp:Float = 240 * elapsed;
		reset += 0.005 * frameLerp;
		var thing:Float = Math.sin(reset) * 0.5 * frameLerp;

		game.dad.y += thing;
		if(!PlayState.SONG.notes[curSection].mustHitSection){//Good enough
			game.defaultCamZoom = 0.45;
			game.camFollow.y += thing;
		}
		else 
            game.defaultCamZoom = 0.65;
	}
}