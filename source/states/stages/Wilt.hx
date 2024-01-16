package states.stages;

import states.stages.objects.*;
import openfl.display.BlendMode;

class Wilt extends BaseStage
{
	// If you're moving your stage from PlayState to a stage file,
	// you might have to rename some variables if they're missing, for example: camZooming -> game.camZooming
	
	override function create()
	{
		// Spawn your stage sprites here.
		// Characters are not ready yet on this function, so you can't add things above them yet.
		// Use createPost() if that's what you want to do.		
		var p1:BGSprite = new BGSprite('p1', -250, -150);
		p1.setGraphicSize(Std.int(p1.width * 1.22));
		p1.updateHitbox();
		var p2:BGSprite = new BGSprite('p2', -250, -150);
		p2.setGraphicSize(Std.int(p2.width * 1.22));
		p2.updateHitbox();

		var bg:BGSprite = new BGSprite('bg', -250, -150);
		bg.setGraphicSize(Std.int(bg.width * 1.22));
		bg.updateHitbox();
		var bg2:BGSprite = new BGSprite('bg2', -250, -150);
		bg2.setGraphicSize(Std.int(bg2.width * 1.22));
		bg2.updateHitbox();

		var window:BGSprite = new BGSprite('window_bottom', -650, -2050);
		window.setGraphicSize(Std.int(window.width * 4.5));
		window.updateHitbox();
		var poc:BGSprite = new BGSprite('pocBackground', -450, -450);
		poc.setGraphicSize(Std.int(poc.width * 1.75));
		poc.updateHitbox();
		var gradent:BGSprite = new BGSprite('gradent', -1050, -2050);
		gradent.setGraphicSize(Std.int(gradent.width * 4.5));
		gradent.updateHitbox();
		gradent.blend = BlendMode.OVERLAY;

		add(window);
		add(poc);
		add(gradent);
		add(bg2);
		add(bg);
		add(p2);
		add(p1);
	}
	
	override function createPost()
	{
		// Use this function to layer things above characters!
	}

	override function update(elapsed:Float)
	{
		// Code here
		if(curStep == 0){
			for(i in 0...game.strumLineNotes.length) PlayState.instance.strumLineNotes.members[i].strumRGB();
			for(i in 0...PlayState.instance.unspawnNotes.length) PlayState.instance.unspawnNotes[i].changeRGB();
		}
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