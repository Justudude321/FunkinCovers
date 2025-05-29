package states.stages;

import states.stages.objects.*;
import cutscenes.CutsceneHandler;

class City extends BaseStage
{
	// If you're moving your stage from PlayState to a stage file,
	// you might have to rename some variables if they're missing, for example: camZooming -> game.camZooming

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

		game.skipCountdown = true;
		setStartCallback(info);
	}

	//Cutscene stuff
	var cutsceneHandler:CutsceneHandler;
	var lights:BGSprite;
	function prepareCutscene(){
		cutsceneHandler = new CutsceneHandler();
		camHUD.alpha = 0.00001;
		inCutscene = true;

		lights = new BGSprite('heart', 0, 0, ['sign2 instance']);
		lights.animation.addByPrefix('start', 'sign2 instance', 14, false);
		lights.setGraphicSize(Std.int(lights.width*0.75),Std.int(lights.height*0.75));
		lights.updateHitbox();
		lights.screenCenter();
		add(lights);
		lights.cameras = [camOther];

		
		cutsceneHandler.finishCallback = function(){
			startCountdown();
			FlxTween.tween(camHUD, {alpha: 1}, 1, {ease: FlxEase.cubeOut});
		}
	}
	
	function info(){
		prepareCutscene();
		cutsceneHandler.endTime = 4.8;
		Paths.sound('lightHum');
		var hum:FlxSound = new FlxSound().loadEmbedded(Paths.sound('lightHum'));
		FlxG.sound.list.add(hum);

		cutsceneHandler.timer(0, function()
		{
			hum.play();
			lights.animation.play('start', true);
		});
		
		cutsceneHandler.timer(4, function(){
			FlxTween.tween(lights, {alpha: 0}, 0.8, 
                {ease: FlxEase.cubeOut, onComplete: 
				function(twn:FlxTween){
                    lights.destroy();
                }});
			inCutscene = false;
		});
	}
}