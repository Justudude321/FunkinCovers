package states.stages;

import states.stages.objects.*;
import objects.Note;

class Singstar extends BaseStage
{
	// If you're moving your stage from PlayState to a stage file,
	// you might have to rename some variables if they're missing, for example: camZooming -> game.camZooming

	var menace:BGSprite;
	var mic:BGSprite;
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
		mic = new BGSprite('micthrow', -577.5, 155, ['micthrow anim']);
		mic.animation.addByPrefix('throw', 'micthrow anim', 24, false);
		mic.animation.addByPrefix('hit', 'micthrow hit', 24, false);
		add(mic);
		mic.alpha = 0;

		game.oppHitDrain = true;
		game.drainAmount = 0.0182;
	}

	override function update(elapsed:Float)
	{
		// Code here
		var dadAnim:String = dad.animation.curAnim.name;
		if(dadAnim == 'hey'){
			sparkles.animation.play("hey", true);
			sparkles.x = offsetX;
			sparkles.y = offsetY;
			dad.animation.finishCallback = function(name:String)
			{
				sparkles.animation.play('idle', true);
			};
		}
		else if(dadAnim == 'idle'){
			sparkles.x = offsetX;
			sparkles.y = offsetY;
		}
		sparkles.visible = (dadAnim == 'hurt' || dadAnim == 'shocked') ?
		false : true;

		// Timing with mic
		if(dadAnim == 'hurt' && dad.animation.curAnim.curFrame == 7)
			mic.destroy();
		if (boyfriend.curCharacter == "solid" && boyfriend.animation.curAnim.name == "transition"){
			if (boyfriend.animation.curAnim.curFrame == 9){
				mic.alpha = 1;
				mic.animation.play('throw', true);
			}
		}

		// Force camera
		if (curStep >= 1150 && curStep < 1156)
			camFollow.setPosition(1017.5, 545);
		if (curStep >= 1072 && curStep < 1168)
			game.camZooming = false;
	}
	
	override function stepHit()
	{
		// Code here
		switch(curStep){
			case 871:// Zoom to transition
				FlxTween.tween(camFollow, {x: 717.5}, (Conductor.stepCrochet / 1000) * 24, {ease: FlxEase.sineOut});
				FlxTween.tween(camFollow, {y: 445}, (Conductor.stepCrochet / 1000) * 24, {ease: FlxEase.sineIn});
				FlxTween.tween(camGame, {zoom: 0.7}, (Conductor.stepCrochet / 1000) * 20, {ease: FlxEase.quintIn});
			
			case 880:
				camFollow.setPosition(867.5, 545);
				FlxTween.tween(camGame, {zoom: 0.7}, (Conductor.stepCrochet / 1000) * 15, {ease: FlxEase.quadIn});
			
			case 1072:// Opp pops off
				FlxTween.tween(menace, {alpha: 1}, ((Conductor.stepCrochet / 1000) * 16) * 6 / 2, {ease: FlxEase.quadIn});
				FlxTween.tween(camGame, {zoom: 1.4}, ((Conductor.stepCrochet / 1000) * 16) * 6, {ease: FlxEase.quadIn});
				FlxTween.tween(camFollow, {x: 452}, ((Conductor.stepCrochet / 1000) * 16) * 4, {ease: FlxEase.quadOut});

			case 1150:// "STOP!"
				game.cameraSpeed = 2;

			case 1156:
				camFollow.setPosition(408, 326.5);
				
			case 1168:// Sigh
				FlxTween.tween(menace, {alpha: 0}, 0.7, 
				{ease: FlxEase.quadOut, onComplete: 
				function(twn:FlxTween){
					menace.destroy();
				}});
				game.cameraSpeed = 1;
				game.camZooming = true;
				defaultCamZoom = 0.7;

			case 1172:
				dad.animation.paused = true;
				dad.specialAnim = true;

			case 1174:
				defaultCamZoom = 0.9;

			case 1184:
				dad.animation.paused = false;
			
			case 1710:// "Listen to me you jerk"
				game.camZooming = false;
				FlxTween.tween(camFollow, {x: 1067.5}, (Conductor.stepCrochet / 1000) * 14, {ease: FlxEase.quadOut});
				FlxTween.tween(camGame, {zoom: 1.5}, (Conductor.stepCrochet / 1000) * 14, 
				{ease: FlxEase.quadIn, onComplete:
				function(twn:FlxTween) {
					game.camZooming = true;
					camFollow.x = 867.5;
				}});
		}
	}

	override function eventCalled(eventName:String, value1:String, value2:String, flValue1:Null<Float>, flValue2:Null<Float>, strumTime:Float)
	{
		switch(eventName)
		{
			case "Play Animation":
				if (value1 == "no") {
					camFollow.x = 867.5;
					FlxTween.tween(camFollow, {x: 1017.5}, (Conductor.stepCrochet / 1000) * 16, {ease: FlxEase.quadOut});
					
					game.camZooming = false;
					FlxTween.tween(camGame, {zoom: 1.4}, (Conductor.stepCrochet / 1000) * 16, 
					{ease: FlxEase.quadIn, onComplete: 
					function(twn:FlxTween){
						game.camZooming = true;
						camFollow.x = 867.5;
					}});
				}
				if (value1 == "hurt"){
					game.camZooming = true;
					mic.animation.play('hit', true);
				}
		}
	}

	override function opponentNoteHit(note:Note)
	{
		// Code here
		var newX:Float = offsetX;
		var newY:Float = offsetY;
		switch(note.noteData){
			case 0:
				newX -= 75;
			case 1:
				newX += 100;
				newY += 50;
			case 2:
				newX -= 25;
				newY -= 50;
			case 3:
				newX += 50;
		}
		sparkles.x = newX;
		sparkles.y = newY;
	}
}