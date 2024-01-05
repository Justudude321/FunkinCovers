package states.stages;

import states.stages.objects.*;

class City extends BaseStage
{
	// If you're moving your stage from PlayState to a stage file,
	// you might have to rename some variables if they're missing, for example: camZooming -> game.camZooming
	
	override function create()
	{
		// Spawn your stage sprites here.
		// Characters are not ready yet on this function, so you can't add things above them yet.
		// Use createPost() if that's what you want to do.
		var sky:BGSprite = new BGSprite('sky', -1245, -890, 0.1, 1.0);
		add(sky);
		var cloud:BGSprite = new BGSprite('clouds', -1245, -890, 0.1, 1.0);
		add(cloud);
		var less:BGSprite = new BGSprite('cityFarBack', -385, -120, 0.2, 1.0);
		add(less);
		var bg:BGSprite = new BGSprite('cityBack', -250, -8, 0.235, 1.0);
		add(bg);
		var needle:BGSprite = new BGSprite('needleSheet', 540, -140, 0.27, 1.0);
		add(needle);
		var wheel:BGSprite = new BGSprite('wheel', -233, -34, 0.27, 1.0);
		add(wheel);
		var fg:BGSprite = new BGSprite('cityFront', -625, -48, 0.285, 1.0);
		add(fg);
		var floor:BGSprite = new BGSprite('floor', -855, 774);
		add(floor);
		var left:BGSprite = new BGSprite('buildingLeft', -990, -890);
		add(left);
		var right:BGSprite = new BGSprite('buildingRight', 1360, -890);
		add(right);

		// var lights:BGSprite = new BGSprite('heart', 0, 0, ['sign2 instance'], true);
		// add(lights);
		// lights.setGraphicSize(Std.int(lights.width*0.75),Std.int(lights.height*0.75));
		// lights.updateHitbox();
		// lights.screenCenter();
		// lights.alpha = 0.5;
		// lights.cameras = [camHUD];
	}
	
	override function createPost()
	{
		// Use this function to layer things above characters!
	}

	override function update(elapsed:Float)
	{
		// Code here
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