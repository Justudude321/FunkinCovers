package states.stages;

import substates.PauseSubState;
import states.stages.objects.*;

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
		var backstage:BGSprite = new BGSprite('camFlash', -350, -80);
		backstage.setGraphicSize(Std.int(backstage.width*1.65),Std.int(backstage.height*1.55));
		backstage.updateHitbox();
		add(backstage);
		backstage.alpha = 0.94;
		sloth = new BGSprite('metal', 375, 450, 0.9, 0.9, ['metalsos'], true);
		add(sloth);
		wrath = new BGSprite('rage', 160, 240, 0.92, 0.92, ['angrysos'], true);
		add(wrath);
		if(skip) game.skipCountdown = true;//Seamless enough
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

	var balls:Bool = false;//Does infinite thing, adding gimmicks later
	override function update(elapsed:Float)
	{
		// Code here
		if(curStep == 1) game.cameraSpeed = 1;
		var currentBeat:Float = (Conductor.songPosition/5000)*(Conductor.bpm/60);
		var thing:Float = Math.sin((currentBeat+12*12)*Math.PI);

		sloth.y = 300 + 70*thing;
		greed.y = 400 + 60*thing;
		wrath.y = 120 - 70*thing;
	}

	// Steps, Beats and Sections:
	//    curStep, curDecStep
	//    curBeat, curDecBeat
	//    curSection
	override function stepHit()
	{
		// Code here
		if(curStep == 1296 && balls) {
			skip = true;
			PauseSubState.restartSong(true);
		}
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