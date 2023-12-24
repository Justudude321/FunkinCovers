package states.stages;

import states.stages.objects.*;

class Alley extends BaseStage
{
	// If you're moving your stage from PlayState to a stage file,
	// you might have to rename some variables if they're missing, for example: camZooming -> game.camZooming

	var alleywall:BGSprite;
	var alleyfloor:BGSprite;
	var jacket:BGSprite;
	var cameraTwn:FlxTween;

	override function create()
	{
		// Spawn your stage sprites here.
		// Characters are not ready yet on this function, so you can't add things above them yet.
		// Use createPost() if that's what you want to do.

		var bg:BGSprite = new BGSprite('alley_swag_wall', -870, -360, 0.9, 0.9, ['wal style change'], true);
		add(bg);
		var bg2:BGSprite = new BGSprite('alley_swag_ground', -600, -350, ['flo style change'], true);
		add(bg2);

		alleywall = new BGSprite('alleywall', -870, -360, 0.9, 0.9);
		add(alleywall);
		alleyfloor = new BGSprite('alleyground', -600, -350);
		add(alleyfloor);
	}
	
	override function createPost()
	{
		// Use this function to layer things above characters!
		jacket = new BGSprite('jacket', 450, 400);
		jacket.visible = false;
		add(jacket);
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
		if (curStep == 928)
			FlxTween.tween(FlxG.camera, {zoom: 1.3}, 2.5, {ease: FlxEase.sineIn, onComplete: function (twn:FlxTween) {cameraTwn = null;}});
		if (curStep == 957){
			jacket.visible = true;
			FlxTween.tween(jacket, {x: 2500}, 0.15, {ease: FlxEase.linear, onComplete: function(twn:FlxTween){jacket.visible = false;}});		
		}

		if (curStep == 960 || curStep == 1344){
			alleywall.visible = false;
			alleyfloor.visible = false;
		}
		else if (curStep == 1216 || curStep == 1472){
			alleywall.visible = true;
			alleyfloor.visible = true;
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
				//precacheImage('myImage') //preloads myImage.png
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
						//precacheImage('myImageOne') //preloads myImageOne.png
						//precacheSound('mySoundOne') //preloads sounds/mySoundOne.ogg
						//precacheMusic('myMusicOne') //preloads music/myMusicOne.ogg

					// If value 1 is "coolswag", it will preload these assets:
					case 'coolswag':
						//precacheImage('myImageTwo') //preloads myImageTwo.png
						//precacheSound('mySoundTwo') //preloads sounds/mySoundTwo.ogg
						//precacheMusic('myMusicTwo') //preloads music/myMusicTwo.ogg
					
					// If value 1 is not "blah blah" or "coolswag", it will preload these assets:
					default:
						//precacheImage('myImageThree') //preloads myImageThree.png
						//precacheSound('mySoundThree') //preloads sounds/mySoundThree.ogg
						//precacheMusic('myMusicThree') //preloads music/myMusicThree.ogg
				}
		}
	}
}