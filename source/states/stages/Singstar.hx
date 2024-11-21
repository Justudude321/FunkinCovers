package states.stages;

import states.stages.objects.*;
import objects.Note;

class Singstar extends BaseStage
{
	// If you're moving your stage from PlayState to a stage file,
	// you might have to rename some variables if they're missing, for example: camZooming -> game.camZooming

	var menace:BGSprite;
	override function create()
	{
		// Spawn your stage sprites here.
		// Characters are not ready yet on this function, so you can't add things above them yet.
		// Use createPost() if that's what you want to do.
        var bg:BGSprite = new BGSprite('stageback', -600, -200, 0.9, 0.9);
		add(bg);

		var stageFront:BGSprite = new BGSprite('stagefront', -650, 600, 0.9, 0.9);
		stageFront.setGraphicSize(Std.int(stageFront.width * 1.1));
		stageFront.updateHitbox();
		add(stageFront);

		menace = new BGSprite('liquidred', -605, -190, 0.9, 0.9);
		add(menace);
		menace.alpha = 0;

		if(!ClientPrefs.data.lowQuality) {
			var stageLight:BGSprite = new BGSprite('stage_light', -125, -100, 0.9, 0.9);
			stageLight.setGraphicSize(Std.int(stageLight.width * 1.1));
			stageLight.updateHitbox();
			add(stageLight);
			var stageLight:BGSprite = new BGSprite('stage_light', 1225, -100, 0.9, 0.9);
			stageLight.setGraphicSize(Std.int(stageLight.width * 1.1));
			stageLight.updateHitbox();
			stageLight.flipX = true;
			add(stageLight);

			var stageCurtains:BGSprite = new BGSprite('stagecurtains', -500, -300, 1.3, 1.3);
			stageCurtains.setGraphicSize(Std.int(stageCurtains.width * 0.9));
			stageCurtains.updateHitbox();
			add(stageCurtains);
		}
	}
	
	var offsetX:Float;
	var offsetY:Float;
	var sparkles:BGSprite;
	override function createPost()
	{
		// Use this function to layer things above characters!
		offsetX = dad.x + 10;
		offsetY = dad.y;
		sparkles = new BGSprite('sparkles', offsetX, offsetY, ['cool sparkles0']);
		sparkles.animation.addByPrefix('idle', 'cool sparkles0', 24, true);
		sparkles.animation.addByPrefix('hey', 'cool sparkles hey', 24, true);
		sparkles.animation.play("idle", true);
		add(sparkles);
	}

	override function update(elapsed:Float)
	{
		// Code here
		var daAnim:String = dad.animation.curAnim.name;
		if(daAnim == 'hey'){
			sparkles.animation.play("hey", true);
			sparkles.x = offsetX;
			sparkles.y = offsetY;
			dad.animation.finishCallback = function(name:String)
			{
				sparkles.animation.play('idle', true);
			};
		}

		else if(daAnim == 'idle'){
			sparkles.x = offsetX;
			sparkles.y = offsetY;
		}
		sparkles.visible = (daAnim == 'hurt' || daAnim == 'shocked') ?
		false : true;

		// if getProperty('dad.curCharacter') == 'liquid-guitar' and getProperty('dad.animation.curAnim.name') == 'transition' and getProperty('dad.animation.curAnim.finished') then
		// 	triggerEvent("Change Character", '1', 'liquid')
	}

	override function destroy()
	{
		// Code here
	}

	
	override function countdownTick(count:Countdown, num:Int)
	{
		switch(count)
		{
			case THREE: //num 0
			case TWO: //num 1
			case ONE: //num 2
			case GO: //num 3
			case START: //num 4
		}
	}

	override function startSong()
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
		if(curStep == 1072)
			FlxTween.tween(menace, {alpha: 1}, ((Conductor.stepCrochet / 1000) * 16) * 6 / 2, 
			{ease: FlxEase.quadIn, onComplete: 
				function(twn:FlxTween){}
			});

		if(curStep == 1168)
			FlxTween.tween(menace, {alpha: 0}, 0.7, 
			{ease: FlxEase.quadOut, onComplete: 
				function(twn:FlxTween){
					menace.destroy();
				}
			});
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

	// Note Hit/Miss
	override function goodNoteHit(note:Note)
	{
		// Code here
	}

	var guitarHero:Bool = ClientPrefs.data.guitarHeroSustains;
	override function opponentNoteHit(note:Note)
	{
		// Code here
		game.health = !(guitarHero && note.isSustainNote) ? 
		Math.max(game.health - 0.0182, 0.30) : game.health;
		
		PlayState.instance.iconP1.animation.curAnim.curFrame = 
		(game.health < 0.4) ? 1 : 0;
		PlayState.instance.iconP2.animation.curAnim.curFrame = 
		(game.health > 1.6) ? 1 : 0;

		var newX:Float = offsetX;
		var newY:Float = offsetY;
		switch(note.noteData){
			case 0:
				newX = offsetX - 75;
			case 1:
				newX = offsetX + 100;
				newY = offsetY + 50;
			case 2:
				newX = offsetX - 25;
				newY = offsetY - 50;
			case 3:
				newX = offsetX + 50;
		}
		sparkles.x = newX;
		sparkles.y = newY;
	}

	override function noteMiss(note:Note)
	{
		// Code here
	}

	override function noteMissPress(direction:Int)
	{
		// Code here
	}
}