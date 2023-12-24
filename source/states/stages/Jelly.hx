package states.stages;

import states.stages.objects.*;

class Jelly extends BaseStage
{
	// If you're moving your stage from PlayState to a stage file,
	// you might have to rename some variables if they're missing, for example: camZooming -> game.camZooming

	var skellies:BGSprite;
	override function create()
	{
		// Spawn your stage sprites here.
		// Characters are not ready yet on this function, so you can't add things above them yet.
		// Use createPost() if that's what you want to do.

		camHUD.alpha = 0.001;
		var bg:BGSprite = new BGSprite('ourple', -850, -770);
		add(bg);
		
		skellies = new BGSprite('skelliebros', 0, 460, ['Skellies Dance']);
		skellies.animation.addByPrefix('idle', 'Skellies Dance', 24, false);
		skellies.animation.addByPrefix('idle-alt', 'SkelliesE Dance', 24, false);
		skellies.animation.addByPrefix('transform', 'Skellies Transform', 24, false);
		add(skellies);
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

		if (curStep == 128){
			FlxTween.tween(camHUD, {alpha: 1}, 1, {onComplete: function(twn:FlxTween)
				{}});
			game.cameraSpeed = 1;				
		}
		if (curStep == 1529){
			skellies.animation.play('transform', true);
			skellies.x = 0 - 20;
			skellies.y = 460 - 15;
		}
		if (curStep == 1536){
			skellies.x = 0;
			skellies.y = 460;
		}
		if (curStep == 1584)game.cameraSpeed = 1;
		if (curStep == 1856)game.cameraSpeed = 100;
		if (curStep == 1921)boyfriendGroup.alpha = 0;
	}
	override function beatHit()
	{
		// Code here
		if(curStep > 1534)skellies.animation.play("idle-alt", true);
		else if(curStep < 1531)skellies.animation.play("idle", true);

		if(curBeat == 384){
			var flash = new BGSprite('camFlash',0,0);
			flash.scale.set(2,2);
			flash.cameras = [camOther];
			add(flash);
			FlxTween.tween(flash, {alpha: 0}, 0.4, {ease: FlxEase.quartIn, onComplete: 
				function(twn:FlxTween){flash.destroy();}
			});	
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