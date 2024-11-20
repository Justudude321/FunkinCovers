package states.stages;

import states.stages.objects.*;
import objects.Note;

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

	// Steps, Beats and Sections:
	//    curStep, curDecStep
	//    curBeat, curDecBeat
	//    curSection
	override function stepHit()
	{
		// Code here
		if (curStep == 128){
			FlxTween.tween(camHUD, {alpha: 1}, 1, {onComplete: 
				function(twn:FlxTween){}
			});
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
		if (curStep == 1584) game.cameraSpeed = 1;
		if (curStep == 1856) game.cameraSpeed = 100;
		if (curStep == 1921) boyfriendGroup.alpha = 0;
	}
	override function beatHit()
	{
		// Code here
		if(curStep > 1534)skellies.animation.play("idle-alt", true);
		else if(curStep < 1531)skellies.animation.play("idle", true);

		if(curBeat == 384){
			var flash = new BGSprite(null,0,0);
			flash.makeGraphic(Std.int(FlxG.width), Std.int(FlxG.height), FlxColor.WHITE);
			flash.cameras = [camOther];
			add(flash);
			FlxTween.tween(flash, {alpha: 0}, 0.4, {ease: FlxEase.quartIn, onComplete: 
				function(twn:FlxTween){flash.destroy();}
			});
		}
	}

	// Note Hit/Miss
	var guitarHero:Bool = ClientPrefs.data.guitarHeroSustains;
	override function opponentNoteHit(note:Note)
	{
		// Code here
		game.health = !(guitarHero && note.isSustainNote) ? 
		Math.max(game.health - 0.01, 0.30) : game.health;
		PlayState.instance.iconP1.animation.curAnim.curFrame = 
		(game.health < 0.4) ? 1 : 0;
	}
}