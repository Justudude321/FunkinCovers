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
		camGame.bgColor.alphaFloat = 0.95;
		camGame.bgColor = FlxColor.WHITE;

		sloth = new BGSprite('metal', 375, 450, 0.9, 0.9, ['metalsos'], true);
		add(sloth);
		wrath = new BGSprite('rage', 160, 240, 0.92, 0.92, ['angrysos'], true);
		add(wrath);

		game.skipCountdown = skip;// Seamless enough, ugh -_-
		game.cameraSpeed = skip ? 100 : 1;
		game.defaultCamZoom = skip ? 0.7 : 0.8;
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

	var redoAt:Float;
	override function startSong()
	{
		// Code here
		redoAt = FlxG.sound.music.length - 1000;
	}

	// Balls allows the infinite thing for testing purposes
	// Will change it so that it's a chance thing later
	var currentBeat:Float;
	var thing:Float;
	var balls:Bool = true;
	override function update(elapsed:Float)
	{
		// Code here
		if(curStep == 1) game.cameraSpeed = 1;
		currentBeat = (Conductor.songPosition/5000) * (Conductor.bpm/60);
		thing = Math.sin((currentBeat+12*12)*Math.PI);

		sloth.y = 300 + 70 * thing;
		greed.y = 400 + 60 * thing;
		wrath.y = 120 - 70 * thing;

		if(Conductor.songPosition > redoAt && balls){
			skip = true;
			PauseSubState.restartSong(skip);
		}
	}

	override function sectionHit()
	{
		// Code here
		game.defaultCamZoom = (PlayState.SONG.notes[curSection].mustHitSection) ? 0.8 : 0.7;
	}
}