package states.stages;

import openfl.filters.ShaderFilter;
import states.stages.objects.*;
import shaders.DesatWave;
import shaders.BrimCam;
import shaders.Vignette;

class Tower extends BaseStage
{
	// If you're moving your stage from PlayState to a stage file,
	// you might have to rename some variables if they're missing, for example: camZooming -> game.camZooming

	var isDownscroll:Bool;
	var isMiddlescroll:Bool;

	var brimback:BGSprite;
	var brimfloor:BGSprite;
	var brimgraves:BGSprite;
	var hud1:BGSprite;
	var hud2:BGSprite;
	var hud3:BGSprite;

	var genEnter:BGSprite;
	var missingnoEnter:BGSprite;
	var hand:BGSprite;
	var shadow:BGSprite;
	var brimHealth:BGSprite;
	var sludge:BGSprite;

	var bgEffects:DesatWave;
	var pixelFilter:BrimCam;
	var redThing:Vignette;
	var camVig:FlxCamera;
	override function create()
	{
		// Spawn your stage sprites here.
		// Characters are not ready yet on this function, so you can't add things above them yet.
		// Use createPost() if that's what you want to do.
		
		// Stage stuff
		isDownscroll = ClientPrefs.data.downScroll;
		isMiddlescroll = ClientPrefs.data.middleScroll;
		
		brimback = new BGSprite('brimstoneBack', -1130, -350);
		brimfloor = new BGSprite('floor', -1130, -350);
		brimgraves = new BGSprite('graves', -1130, -350);
		brimback.setGraphicSize(Std.int(brimback.width * 6));
		brimback.updateHitbox();
		brimfloor.setGraphicSize(Std.int(brimfloor.width * 6));
		brimfloor.updateHitbox();
		brimgraves.setGraphicSize(Std.int(brimgraves.width * 6));
		brimgraves.updateHitbox();
		add(brimback);
		add(brimfloor);
		add(brimgraves);

		setupHUD(true);
		brimback.antialiasing = false;
		brimfloor.antialiasing = false;
		brimgraves.antialiasing = false;
		brimHealth.antialiasing = false;
		game.skipCountdown = true;

		// Shader Stuff
		bgEffects = new DesatWave();
		pixelFilter = new BrimCam();
		camGame.setFilters([new ShaderFilter(pixelFilter)]);
		camHUD.setFilters([new ShaderFilter(pixelFilter)]);

		redThing = null;
		camVig = new FlxCamera();	
		camVig.bgColor.alpha = 1; // This fixes the ram, kinda??
		FlxG.cameras.add(camVig, false);
		FlxG.cameras.list[2] = camVig; // Had to do this to fix pausing
		FlxG.cameras.list[3] = camOther;
		insert(3, dadGroup);
	}

	override function createPost()
	{
		// Use this function to layer things above characters!
		
		// Animations
		sludge = new BGSprite('muksludge', 0, 0, ['Sludge_01']);
		sludge.animation.addByPrefix('0', 'Sludge_01', 24, false);
		sludge.animation.addByPrefix('1', 'Sludge_02', 24, false);
		sludge.animation.addByPrefix('2', 'Sludge_03', 24, false);
		sludge.cameras = [camOther];
		sludge.setGraphicSize(Std.int(FlxG.width), Std.int(FlxG.height));
		sludge.updateHitbox();
		add(sludge);
		sludge.alpha = 0;
		
		hand = new BGSprite('WA_assets', 348, 370, ['WH_Idle']);
		hand.animation.addByPrefix('hi', 'WH_Intro', 24, false);
		hand.animation.addByPrefix('idle', 'WH_Idle', 24, true);
		hand.animation.addByPrefix('morph', 'WH_ToGF', 24, false);
		hand.scale.set(6,6);
		addBehindGF(hand);
		hand.alpha = 0;

		shadow = new BGSprite('shadow', 390, 635);
		shadow.scale.set(6,6);
		addBehindGF(shadow);
		shadow.alpha = 0;

		genEnter = new BGSprite('enter_gengar', 199, 361, ['gengar entrance']);
		genEnter.animation.addByPrefix('boo', 'gengar entrance', 24, false);
		genEnter.animation.addByPrefix('bye', 'gengar leave', 24, false);
		genEnter.scale.set(6,6);
		add(genEnter);
		genEnter.alpha = 0;

		missingnoEnter = new BGSprite('missingnopokeball_assets', -147, 787, ['Ball_Throw']);
		missingnoEnter.animation.addByPrefix('throw', 'Ball_Throw', 24, false);//beat 399
		missingnoEnter.animation.addByPrefix('idle', 'Ball_Idle_Normal', 24, true);
		missingnoEnter.animation.addByPrefix('cracking', 'Ball_Idle_Break', 24, true);
		missingnoEnter.animation.addByPrefix('breaking', 'Ball_Break', 24, true);
		missingnoEnter.animation.addByPrefix('burst', 'Ball_FinalBurst', 24, false);
		missingnoEnter.scale.set(6,6);
		add(missingnoEnter);
		missingnoEnter.alpha = 0;

		sludge.antialiasing = false;
		hand.antialiasing = false;
		shadow.antialiasing = false;
		genEnter.antialiasing = false;
		missingnoEnter.antialiasing = false;

		setupHUD(false);
		game.timeBar.visible = false;
		game.healthBar.visible = false;
		game.iconP1.visible = false;
		game.iconP2.visible = false;
		game.scoreTxt.y = 0;
		gf.alpha = 0;
		//bfDos.alpha = 0;
	}

	var currentGB:Float = 0;
	var targetGBvalue:Float = 0;
	var lerpVal:Float = 0;
	var reset:Float = 0;
	override function update(elapsed:Float)
	{
		// Code here
		camFollow.setPosition(240, 545);
		brimHealth.setGraphicSize(Std.int(156*(game.healthBar.percent/100)),Std.int(brimHealth.height));
		brimHealth.updateHitbox();
		if (game.health >= 0.5) brimHealth.color = FlxColor.WHITE;
		else brimHealth.color = 0xffFF0000;
		
		// White hand floating
		var frameLerp:Float = 240 * elapsed;
		if (curBeat >= 808 && curBeat <= 872) {
			reset += 0.006;
			hand.y += Math.cos(reset * frameLerp) * 0.075 * frameLerp;	
		}

		// GF Apparition float stuff
		if (curStep >= 3488) {
			reset += 0.002;
			gf.x += Math.cos(reset * frameLerp) * 0.075 * frameLerp;
			shadow.x += Math.cos(reset * frameLerp) * 0.075 * frameLerp;
		}
		if (curStep >= 3490) {
			reset += 0.002;
			gf.y += Math.sin(reset * frameLerp) * 0.075 * frameLerp;
		}

		// Shader Stuff
		if (gf.alpha == 0 && hand.alpha == 0) {
			currentGB = FlxMath.lerp(currentGB, targetGBvalue, 0.0125 * frameLerp);
			pixelFilter.intensity.value = [currentGB];
		}

		if (curBeat >= 864) {
			bgEffects.time.value[0] -= (frameLerp * 0.01) / 8;
			if (lerpVal <= 7.99){
				lerpVal = FlxMath.lerp(lerpVal, 8, 0.004 * frameLerp);
				bgEffects.intensity.value = [lerpVal];
				bgEffects.desat.value = [(lerpVal/8)];
			}
		}

		if (redThing != null)
			redThing.time.value = [Conductor.songPosition / (Conductor.stepCrochet * 8)];
	}

	override function startSong()
	{
		// Code here
		var open1:BGSprite = new BGSprite('opening1', 0, 0);
		var open2:BGSprite = new BGSprite('opening1', 0, 40);
		open1.cameras = [camOther];
		open2.cameras = [camOther];
		add(open1);
		add(open2);
		FlxTween.tween(open1, {x: -1300}, 2, 
			{ease: FlxEase.linear, onComplete: 
			function(twn:FlxTween) {
				open1.destroy();
			}});
		FlxTween.tween(open2, {x: 1300}, 2, 
			{ease: FlxEase.linear, onComplete: 
			function(twn:FlxTween) {
				open2.destroy();
			}});	
	}

	override function stepHit()
	{
		// Code here
		if (curStep == 1594) {
			missingnoEnter.animation.play('throw', true);
			missingnoEnter.alpha = 1;
		}
	}

	override function beatHit()
	{
		// Code here
		switch(curBeat) {
			case 236: // entering and leaving characters
				genEnter.animation.play('boo', true);
				genEnter.alpha = 1;

			case 243:
				genEnter.alpha = 0;
				gf.alpha = 1;

			case 400:
				missingnoEnter.animation.play('idle', true);

			case 410:
				missingnoEnter.animation.play('cracking', true);

			case 420:
				missingnoEnter.animation.play('breaking', true);

			case 427:
				missingnoEnter.animation.play('burst', true);

			case 432:
				missingnoEnter.alpha = 0;
				missingnoEnter.destroy();
				//bfDos.alpha = 1;

			case 596:
				//FlxTween.tween(bfDos, {y: 1200}, 1.5, {onComplete: function(twn:FlxTween){}});
				gf.alpha = 0;
				genEnter.alpha = 1;
				genEnter.animation.play('bye', true);

			case 599:
				genEnter.alpha = 0;
				genEnter.destroy();

			case 600: // Gameboy Shader
				targetGBvalue = (currentGB >= 0.99) ? 0.0 : 1.0;
			
			case 664:
				targetGBvalue = (currentGB >= 0.99) ? 0.0 : 1.0;
			
			case 676:
				gf.alpha = 1;

			case 808:
				hand.alpha = 1;
				shadow.alpha = 1;	
				hand.animation.play('hi', true);

			case 812:
				hand.animation.play('idle', true);

			case 864:
				hand.animation.play('morph', true);
				
				FlxTween.tween(hand, {x: 388, y: 360}, 2);
				FlxTween.tween(shadow, {x: 412, y: 860}, 2);
				FlxTween.tween(FlxG.camera, {zoom: 0.94}, 2.8, 
					{ease: FlxEase.sineIn, onComplete: 
					function (twn:FlxTween) {
						defaultCamZoom = 0.94;
					}});
					
				brimback.shader = bgEffects;
				brimfloor.shader = bgEffects;
				brimgraves.shader = bgEffects;
			
			case 868:
				gf.alpha = 0;
			
			case 872:
				hand.alpha = 0;
				gf.alpha = 1;

				redThing = new Vignette();
				redThing.intenMin.value = [0.0];
				redThing.intenGain.value = [0.3];
				camVig.setFilters([new ShaderFilter(redThing)]);
			
			case 875:
				FlxTween.tween(FlxG.camera, {zoom: 0.55}, 2.8, {ease: FlxEase.linear, onComplete: 
					function (twn:FlxTween){
					defaultCamZoom = 0.55;
					}
				});
		}
	}

	// For events
	override function eventCalled(eventName:String, value1:String, value2:String, flValue1:Null<Float>, flValue2:Null<Float>, strumTime:Float)
	{
		switch(eventName)
		{
			case "muk spit": // Works!! >:)
				if (gf != null) {
					gf.playAnim("Puke", true);
					gf.specialAnim = true;
					new FlxTimer().start(0.31, function(_)
					{
						sludge.alpha = 1;
						sludge.animation.play(Std.string(FlxG.random.int(0, 2)), true);
						new FlxTimer().start(1.8, function(_)
						{
							FlxTween.tween(sludge, {alpha: 0}, 3, {ease: FlxEase.sineIn});
						});
					});
				}
		}
	}

	function setupHUD(which:Bool) {
		if (which) { // onCreate
			if (!isMiddlescroll) {
				hud1 = new BGSprite('buried_1', 0, 30);
				hud1.cameras = [camHUD];
				hud1.setGraphicSize(Std.int(hud1.width * 3));
				hud1.updateHitbox();
				add(hud1);
				hud1.antialiasing = false;
	
				hud2 = new BGSprite('buried_2', 785, 528);
				hud2.cameras = [camHUD];
				hud2.setGraphicSize(Std.int(hud2.width * 3));
				hud2.updateHitbox();
				add(hud2);
				hud2.antialiasing = false;
	
				var hud1HP = {x:hud1.x + 43 * 3, y:hud1.y + 48 * 3}
				var hud2HP = {x:hud2.x + 79 * 3, y:hud2.y + 48 * 3}
				brimHealth = isDownscroll ? 
				new BGSprite('brimstone_healthbar', hud2HP.x, hud2HP.y) : new BGSprite('brimstone_healthbar', hud1HP.x, hud1HP.y);
				brimHealth.cameras = [camHUD];
				add(brimHealth);
	
				var buryHP:BGSprite = isDownscroll ? 
				new BGSprite('brimstone_healthbar', hud1HP.x, hud1HP.y) : new BGSprite('brimstone_healthbar', hud2HP.x, hud2HP.y);
				buryHP.cameras = [camHUD];
				add(buryHP);
				buryHP.antialiasing = false;
			}
			else{
				var daY:Int = isDownscroll ? 510 : 30;
				hud3 = new BGSprite('buried_3', 340, daY);
				hud3.cameras = [camHUD];
				hud3.setGraphicSize(Std.int(hud3.width * 3));
				hud3.updateHitbox();
				add(hud3);
				hud3.antialiasing = false;
	
				var hud3HP = {x:(hud3.x + 78 * 3), y:(hud3.y + 48 * 3) - 1}
				brimHealth = new BGSprite('brimstone_healthbar', hud3HP.x, hud3HP.y);
				brimHealth.cameras = [camHUD];
				add(brimHealth);
			}
		}
		else { // onCreatePost
			var offsetX:Float = 100;
			if (!isMiddlescroll) {
				for (i in 0...game.opponentStrums.length) {
					game.playerStrums.members[i].x = isDownscroll ? 
					880 + (offsetX*i) : 5 + (offsetX*i);
					game.opponentStrums.members[i].x = isDownscroll ? 
					5 + (offsetX*i) : 880 + (offsetX*i);

					game.playerStrums.members[i].y = isDownscroll ? 
					548 : 50;
					game.opponentStrums.members[i].y = isDownscroll ? 
					50 : 548;

					game.opponentStrums.members[i].downScroll = !isDownscroll;
				}
			}
			else{
				for (i in 0...game.opponentStrums.length) {
					game.opponentStrums.members[i].x = -200;
					game.playerStrums.members[i].x = 442 + (offsetX*i);
					if (isDownscroll)
						game.playerStrums.members[i].y = 530;
				}
			}
		}	
	}
}