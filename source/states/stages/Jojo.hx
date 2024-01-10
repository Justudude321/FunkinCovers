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
	}

	var reset:Float = 0;
	override function update(elapsed:Float)
	{
		// Code here
		reset += 0.005;
		var daFrames:Float = (240/FlxG.updateFramerate);
		var thing:Float = Math.sin(reset * daFrames) * 0.5 * daFrames;

		game.dad.y += thing;
		if(PlayState.dadFocus){//Good enough
			game.defaultCamZoom = 0.45;
			game.camFollow.y += thing;
		}
		else game.defaultCamZoom = 0.65;
		
	}
	// Steps, Beats and Sections:
	//    curStep, curDecStep
	//    curBeat, curDecBeat
	//    curSection
	override function stepHit()
	{
		// Code here
	}
	override function beatHit()
	{
		// Code here
	}
	override function sectionHit()
	{
		// Code here
	}

	// Substates for pausing/resuming tweens and timers
	override function closeSubState()
	{
		if(paused)
		{
			//timer.active = true;
			//tween.active = true;
		}
	}

	override function openSubState(SubState:flixel.FlxSubState)
	{
		if(paused)
		{
			//timer.active = false;
			//tween.active = false;
		}
	}

	// For events
	override function eventCalled(eventName:String, value1:String, value2:String, flValue1:Null<Float>, flValue2:Null<Float>, strumTime:Float)
	{
		switch(eventName)
		{
			case "My Event":
		}
	}
	override function eventPushed(event:objects.Note.EventNote)
	{
		// used for preloading assets used on events that doesn't need different assets based on its values
		switch(event.event)
		{
			case "My Event":
				//precacheImage('myImage') //preloads images/myImage.png
				//precacheSound('mySound') //preloads sounds/mySound.ogg
				//precacheMusic('myMusic') //preloads music/myMusic.ogg
		}
	}
	override function eventPushedUnique(event:objects.Note.EventNote)
	{
		// used for preloading assets used on events where its values affect what assets should be preloaded
		switch(event.event)
		{
			case "My Event":
				switch(event.value1)
				{
					// If value 1 is "blah blah", it will preload these assets:
					case 'blah blah':
						//precacheImage('myImageOne') //preloads images/myImageOne.png
						//precacheSound('mySoundOne') //preloads sounds/mySoundOne.ogg
						//precacheMusic('myMusicOne') //preloads music/myMusicOne.ogg

					// If value 1 is "coolswag", it will preload these assets:
					case 'coolswag':
						//precacheImage('myImageTwo') //preloads images/myImageTwo.png
						//precacheSound('mySoundTwo') //preloads sounds/mySoundTwo.ogg
						//precacheMusic('myMusicTwo') //preloads music/myMusicTwo.ogg
					
					// If value 1 is not "blah blah" or "coolswag", it will preload these assets:
					default:
						//precacheImage('myImageThree') //preloads images/myImageThree.png
						//precacheSound('mySoundThree') //preloads sounds/mySoundThree.ogg
						//precacheMusic('myMusicThree') //preloads music/myMusicThree.ogg
				}
		}
	}
}