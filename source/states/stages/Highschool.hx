package states.stages;

import states.stages.objects.*;

class Highschool extends BaseStage
{
	// If you're moving your stage from PlayState to a stage file,
	// you might have to rename some variables if they're missing, for example: camZooming -> game.camZooming
	
	var crowd:BGSprite;
	override function create()
	{
		// Spawn your stage sprites here.
		// Characters are not ready yet on this function, so you can't add things above them yet.
		// Use createPost() if that's what you want to do.
		var bg:BGSprite = new BGSprite('HighSchool', -600,750);
		add(bg);
		var floor:BGSprite = new BGSprite('barrera', -600, 2750);
		add(floor);
		var crowd:BGSprite = new BGSprite('gangbop', -400, 1500, ['Gang Bottom Boppers'], true);
		add(crowd);
	}
	
	override function createPost()
	{
		// Use this function to layer things above characters!
	}

	var a:Float = 0;
	override function update(elapsed:Float)
	{
		// Code here
		if(curStep == 0){
			for (i in 0...PlayState.instance.unspawnNotes.length - 1)
				if(!PlayState.instance.unspawnNotes[i].mustPress) {
					PlayState.instance.unspawnNotes[i].texture = 'noteSkins/jenny';
					PlayState.instance.unspawnNotes[i].rgbShader.enabled = false;
				}
			for (i in 0...game.opponentStrums.length) {
				PlayState.instance.opponentStrums.members[i].texture = 'noteSkins/jenny';
				PlayState.instance.opponentStrums.members[i].useRGBShader = false;
			}
		}
		a += 1/(FlxG.updateFramerate/4) * 1;

		if(PlayState.isDownscroll)
			for (i in 0...game.strumLineNotes.length) game.strumLineNotes.members[i].y = 20 * Math.cos(i/1.5 + a) + 570;
		else 
			for (i in 0...game.strumLineNotes.length) game.strumLineNotes.members[i].y = 20 * Math.cos(i/1.5 + a) + 50;
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
		// if(curBeat % 2 == 0) crowd.animation.play("bop", true);
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