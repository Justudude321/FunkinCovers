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

		game.oppHitDrain = true;
		game.drainAmount = 0.0182;
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