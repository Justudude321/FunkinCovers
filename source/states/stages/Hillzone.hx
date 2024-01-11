package states.stages;

import states.stages.objects.*;

class Hillzone extends BaseStage
{
	// If you're moving your stage from PlayState to a stage file,
	// you might have to rename some variables if they're missing, for example: camZooming -> game.camZooming
	
	override function create()
	{
		// Spawn your stage sprites here.
		// Characters are not ready yet on this function, so you can't add things above them yet.
		// Use createPost() if that's what you want to do.
		var bg:BGSprite = new BGSprite('tfbbg3', -458, -247, 0.3, 0.3);
		add(bg);
		var bg2:BGSprite = new BGSprite('tfbbg2', -480, 410, 0.7, 0.97);
		add(bg2);
		var bg3:BGSprite = new BGSprite('tfbbg', -541, -96);
		bg3.setGraphicSize(Std.int(bg3.width * 1.05));
		bg3.updateHitbox();
		add(bg3);
	}
	
	override function createPost()
	{
		// Use this function to layer things above characters!
	}
	var a:Float = 0;
	var curX:Array<Float> = new Array<Float>();
	var newX:Array<Float> = new Array<Float>();
	var newY:Array<Float> = new Array<Float>();
	var newX2:Array<Float> = new Array<Float>();
	var newY2:Array<Float> = new Array<Float>();
	override function update(elapsed:Float)
	{
		// Code here
		if(curBeat >= 228 && curBeat < 292){
			var speed:Float = 0.5;
			a = a + 1/(FlxG.updateFramerate/4) * speed;
			if(PlayState.isDownscroll)
				for (i in 0...game.strumLineNotes.length) game.strumLineNotes.members[i].y = 20 * Math.cos(i/1.5 + a) + 570;
			else 
				for (i in 0...game.strumLineNotes.length) game.strumLineNotes.members[i].y = 20 * Math.cos(i/1.5 + a) + 50;

			for (i in 0...game.strumLineNotes.length) game.strumLineNotes.members[i].x = 20 * Math.cos(i/1.5 + a) + curX[i];
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
		if(curBeat == 227){
			for (i in 0...game.strumLineNotes.length) curX[i] = PlayState.instance.strumLineNotes.members[i].x;
			for (i in 0...game.opponentStrums.length){
				newX[i] = game.playerStrums.members[i].x;
				newY[i] = game.playerStrums.members[i].y;
				newX2[i] = game.opponentStrums.members[i].x;
				newY2[i] = game.opponentStrums.members[i].y;
			}
		}
		if(curBeat == 292)
			for (i in 0...game.opponentStrums.length){
				FlxTween.tween(game.playerStrums.members[i], {x: newX[i]}, 0.25, {
					ease: FlxEase.cubeInOut, onComplete: function(twn:FlxTween){}
				});
				FlxTween.tween(game.playerStrums.members[i], {y: newY[i]}, 0.25, {
					ease: FlxEase.cubeInOut, onComplete: function(twn:FlxTween){}
				});
				FlxTween.tween(game.opponentStrums.members[i], {x: newX2[i]}, 0.25, {
					ease: FlxEase.cubeInOut, onComplete: function(twn:FlxTween){}
				});
				FlxTween.tween(game.opponentStrums.members[i], {y: newY2[i]}, 0.25, {
					ease: FlxEase.cubeInOut, onComplete: function(twn:FlxTween){}
				});
			}
		if(curBeat == 568)
			for (i in 0...game.opponentStrums.length){
				if(PlayState.isDownscroll){//down to up
					FlxTween.tween(game.playerStrums.members[i], {y: -500}, 1.5, {
						ease: FlxEase.cubeInOut, onComplete: function(twn:FlxTween){}
					});
					FlxTween.tween(game.opponentStrums.members[i], {y: -500}, 1.5, {
						ease: FlxEase.cubeInOut, onComplete: function(twn:FlxTween){}
					});
				}
				else{
					FlxTween.tween(game.playerStrums.members[i], {y: 900}, 2, {
						ease: FlxEase.cubeInOut, onComplete: function(twn:FlxTween){}
					});
					FlxTween.tween(game.opponentStrums.members[i], {y: 900}, 2, {
						ease: FlxEase.cubeInOut, onComplete: function(twn:FlxTween){}
					});
				}
			}
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