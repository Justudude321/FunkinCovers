package states.stages;

import states.stages.objects.*;
import cutscenes.CutsceneHandler;

class City extends BaseStage
{
	// If you're moving your stage from PlayState to a stage file,
	// you might have to rename some variables if they're missing, for example: camZooming -> game.camZooming

	var lights:BGSprite;
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

		lights = new BGSprite('heart', 0, 0, ['sign2 three']);
		lights.animation.addByPrefix('3', 'sign2 three', 20, false);
		lights.animation.addByPrefix('2', 'sign2 two', 20, false);
		lights.animation.addByPrefix('1', 'sign2 one', 20, false);
		lights.animation.addByPrefix('go', 'sign2 go', 20, false);
		lights.setGraphicSize(Std.int(lights.width*0.75),Std.int(lights.height*0.75));
		lights.updateHitbox();
		lights.screenCenter();
		lights.cameras = [camOther];
		add(lights);

		camHUD.alpha = 0.001;
		game.introSoundsSuffix = "-heart";
	}

	override function countdownTick(count:Countdown, num:Int)
	{
		switch(count)
		{
			case THREE: //num 0
				lights.animation.play('3', true);

			case TWO: //num 1
				if (game.countdownReady != null)
					game.countdownReady.kill();
				lights.animation.play('2', true);

			case ONE: //num 2
				if (game.countdownSet != null)
					game.countdownSet.kill();
				lights.animation.play('1', true);

			case GO: //num 3
				if (game.countdownGo != null)
					game.countdownGo.kill();
				lights.animation.play('go', true);

			case START: //num 4
				FlxTween.tween(lights, {alpha: 0}, Conductor.crochet / 1000, 
				{ease: FlxEase.cubeInOut, onComplete: 
				function(twn:FlxTween) {
					lights.destroy();
				}});
				FlxTween.tween(camHUD, {alpha: 1}, Conductor.crochet / 1000, {ease: FlxEase.cubeInOut});
		}
	}
}