package states.stages;

import states.stages.objects.*;
import substates.PauseSubState;

class Fitin extends BaseStage
{
	// If you're moving your stage from PlayState to a stage file,
	// you might have to rename some variables if they're missing, for example: camZooming -> game.camZooming

	var sloth:BGSprite;
	var greed:BGSprite;
	var wrath:BGSprite;
	static var skip = false;
	override function create()
	{
		// Spawn your stage sprites here.
		// Characters are not ready yet on this function, so you can't add things above them yet.
		// Use createPost() if that's what you want to do.
		var bg = new BGSprite(null,-400,-100);
		bg.makeGraphic(Std.int(FlxG.width * 2), Std.int(FlxG.height * 2), FlxColor.WHITE);
		add(bg);
		bg.alpha = 0.95;

		sloth = new BGSprite('metal', 375, 450, 0.9, 0.9, ['metalsos'], true);
		add(sloth);
		wrath = new BGSprite('rage', 160, 240, 0.92, 0.92, ['angrysos'], true);
		add(wrath);

		game.skipCountdown = skip;//Seamless enough
		game.cameraSpeed = skip ? 100 : 1;
		skip = false;
	}

	override function createPost() 
	{
		// Use this function to layer things above characters!
		greed = new BGSprite('grinch', -50, 575, 1.2, 1.2, ['grinchsos'], true);
		greed.setGraphicSize(Std.int(greed.width*1.2),Std.int(greed.height*1.2));
		greed.updateHitbox();
		add(greed);
	}

	// Allows infinite thing for testing purposes
	// Will change it so that it's a chance thing
	var balls:Bool = true;
	var redoAt:Float = FlxG.sound.music.length - 1000;
	override function update(elapsed:Float)
	{
		// Code here
		if(curStep == 1) game.cameraSpeed = 1;
		var currentBeat:Float = (Conductor.songPosition/5000) * (Conductor.bpm/60);
		var thing:Float = Math.sin((currentBeat+12*12)*Math.PI);

		sloth.y = 300 + 70 * thing;
		greed.y = 400 + 60 * thing;
		wrath.y = 120 - 70 * thing;

		if(Conductor.songPosition > redoAt && balls){
			skip = true;
			PauseSubState.restartSong(skip);
		}
	}

	// Try to do cam follow note later
}