package states.stages;

import states.stages.objects.*;

class Tower extends BaseStage
{
	// If you're moving your stage from PlayState to a stage file,
	// you might have to rename some variables if they're missing, for example: camZooming -> game.camZooming

	var gray1:BGSprite;
	var gray2:BGSprite;
	var gray3:BGSprite;
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
	override function create()
	{
		// Spawn your stage sprites here.
		// Characters are not ready yet on this function, so you can't add things above them yet.
		// Use createPost() if that's what you want to do.

		gray1 = new BGSprite('brimstoneBack-gray', 605, 350);
		add(gray1);
		gray2 = new BGSprite('floor-gray', 605, 350);
		add(gray2);
		gray3 = new BGSprite('graves-gray', 605, 350);
		add(gray3);
		gray1.scale.set(3.5,3.5);
		gray2.scale.set(3.5,3.5);
		gray3.scale.set(3.5,3.5);
	
		brimback = new BGSprite('brimstoneBack', 605, 350);
		add(brimback);
		brimfloor = new BGSprite('floor', 605, 350);
		add(brimfloor);
		brimgraves = new BGSprite('graves', 605, 350);
		add(brimgraves);
		brimback.scale.set(3.5,3.5);
		brimfloor.scale.set(3.5,3.5);
		brimgraves.scale.set(3.5,3.5);
		
		if(!PlayState.isMiddlescroll){
			hud1 = new BGSprite('buried_1', 0, 28);
			hud1.cameras = [camHUD];
			hud1.setGraphicSize(Std.int(hud1.width*3.4),Std.int(hud1.height*3.4));
			hud1.updateHitbox();
			add(hud1);

			hud2 = new BGSprite('buried_2', 719, 518);
			hud2.cameras = [camHUD];
			hud2.setGraphicSize(Std.int(hud2.width*3.4),Std.int(hud2.height*3.4));
			hud2.updateHitbox();
			add(hud2);
			hud1.antialiasing = false;
			hud2.antialiasing = false;	
			if(!PlayState.isDownscroll){
				brimHealth = new BGSprite('brimstone_healthbar',  148, 190);
				brimHealth.cameras = [camHUD];
				brimHealth.setGraphicSize(Std.int(brimHealth.width*1.12),5);
				brimHealth.updateHitbox();	
				add(brimHealth);

				var buryHP:BGSprite = new BGSprite('brimstone_healthbar', 989, 680);
				buryHP.cameras = [camHUD];
				buryHP.setGraphicSize(Std.int(buryHP.width*1.12),5);
				buryHP.updateHitbox();	
				add(buryHP);
				brimHealth.antialiasing = false;
				buryHP.antialiasing = false;
				
			}
			else{
				brimHealth = new BGSprite('brimstone_healthbar',  989, 680);
				brimHealth.cameras = [camHUD];
				brimHealth.setGraphicSize(Std.int(brimHealth.width*1.12),5);
				brimHealth.updateHitbox();	
				add(brimHealth);

				var buryHP:BGSprite = new BGSprite('brimstone_healthbar', 148, 190);
				buryHP.cameras = [camHUD];
				buryHP.setGraphicSize(Std.int(buryHP.width*1.12),5);
				buryHP.updateHitbox();	
				add(buryHP);
				brimHealth.antialiasing = false;
				buryHP.antialiasing = false;
			}

		}
		else{
			var daY:Int = 30;
			if(PlayState.isDownscroll) daY = 510;
			hud3 = new BGSprite('buried_3', 295, daY);
			hud3.cameras = [camHUD];
			hud3.setGraphicSize(Std.int(hud3.width*3.4),Std.int(hud3.height*3.4));
			hud3.updateHitbox();
			add(hud3);

			brimHealth = new BGSprite('brimstone_healthbar',  561, daY+162);
			brimHealth.cameras = [camHUD];
			brimHealth.setGraphicSize(Std.int(brimHealth.width*1.12),5);
			brimHealth.updateHitbox();
			add(brimHealth);
			hud3.antialiasing = false;
			brimHealth.antialiasing = false;
		}

		sludge = new BGSprite('muksludge', 0, 0, ['Sludge_01']);
		sludge.animation.addByPrefix('0', 'Sludge_01', 24, false);
		sludge.animation.addByPrefix('1', 'Sludge_02', 24, false);
		sludge.animation.addByPrefix('2', 'Sludge_03', 24, false);
		sludge.cameras = [camOther];
		sludge.setGraphicSize(1280,720);
		sludge.updateHitbox();
		add(sludge);
		sludge.alpha = 0;

		hand = new BGSprite('WA_assets', 888, 375, ['WH_Idle']);
		hand.animation.addByPrefix('hi', 'WH_Intro', 24, false);
		hand.animation.addByPrefix('idle', 'WH_Idle', 24, true);
		hand.animation.addByPrefix('morph', 'WH_ToGF', 24, false);
		hand.scale.set(3.5,3.5);
		add(hand);
		shadow = new BGSprite('shadow', 910, 575);
		shadow.scale.set(3.5,3.5);
		add(shadow);
		hand.alpha = 0;
		shadow.alpha = 0;

		insert(6, dadGroup);

		gray1.antialiasing = false;
		gray2.antialiasing = false;
		gray3.antialiasing = false;
		brimback.antialiasing = false;
		brimfloor.antialiasing = false;
		brimgraves.antialiasing = false;
		sludge.antialiasing = false;
		
		hand.antialiasing = false;
		shadow.antialiasing = false;
		game.skipCountdown = true;
	}
	
	override function createPost()
	{
		// Use this function to layer things above characters!
		genEnter = new BGSprite('enter_gengar', 762, 372, ['gengar entrance']);
		genEnter.animation.addByPrefix('boo', 'gengar entrance', 24, false);
		genEnter.animation.addByPrefix('bye', 'gengar leave', 24, false);
		genEnter.scale.set(3.5,3.5);
		add(genEnter);
		genEnter.alpha = 0;
		missingnoEnter = new BGSprite('missingnopokeball_assets', 562, 642, ['Ball_Throw']);
		missingnoEnter.animation.addByPrefix('throw', 'Ball_Throw', 24, false);//beat 399
		missingnoEnter.animation.addByPrefix('idle', 'Ball_Idle_Normal', 24, true);
		missingnoEnter.animation.addByPrefix('cracking', 'Ball_Idle_Break', 24, true);
		missingnoEnter.animation.addByPrefix('breaking', 'Ball_Break', 24, true);
		missingnoEnter.animation.addByPrefix('burst', 'Ball_FinalBurst', 24, false);
		missingnoEnter.scale.set(3.5,3.5);
		add(missingnoEnter);
		missingnoEnter.alpha = 0;

		genEnter.antialiasing = false;
		missingnoEnter.antialiasing = false;
		hand.antialiasing = false;
		shadow.antialiasing = false;

	}

	var switched:Bool = false;
	var reset:Float = 0;
	override function update(elapsed:Float)
	{
		// Code here
		//opening + health
		if(curStep == 0){
			game.scoreTxt.y = 0;
			gf.alpha = 0;
			//bfDos.alpha = 0;
			var open1:BGSprite = new BGSprite('opening1', 0, 0);
			var open2:BGSprite = new BGSprite('opening2', 0, 0);
			open1.cameras = [camOther];
			open2.cameras = [camOther];
			add(open1);
			add(open2);
			FlxTween.tween(open1, {x: -1300}, 2, {ease: FlxEase.linear, onComplete: function(twn:FlxTween){open1.destroy();}});
			FlxTween.tween(open2, {x: 1300}, 2, {ease: FlxEase.linear, onComplete: function(twn:FlxTween){open2.destroy();}});	
		}

		brimHealth.setGraphicSize(Std.int(174*(game.healthBar.percent/100)),Std.int(brimHealth.height));
		brimHealth.updateHitbox();
		if(game.health >= 0.5)brimHealth.color = FlxColor.WHITE;
		else brimHealth.color = 0xffFF0000;

		//All the scrolls
		if(!PlayState.isDownscroll){//up
			if(!PlayState.isMiddlescroll && !switched){//no mid
				for (i in 0...game.opponentStrums.length){
					game.opponentStrums.members[i].y = 540;
					game.opponentStrums.members[i].downScroll = true;
				}
				game.playerStrums.members[0].x = 4;
				game.playerStrums.members[1].x = 116;
				game.playerStrums.members[2].x = 228;
				game.playerStrums.members[3].x = 340;
				game.opponentStrums.members[0].x = 830;
				game.opponentStrums.members[1].x = 942;
				game.opponentStrums.members[2].x = 1054;
				game.opponentStrums.members[3].x = 1166;	
				switched = true;
			}
			else if(PlayState.isMiddlescroll)
				for (i in 0...game.opponentStrums.length) game.opponentStrums.members[i].alpha = 0;
		}
		else{//down
			if(!PlayState.isMiddlescroll && !switched){//no mid
				for (i in 0...game.opponentStrums.length){
					game.opponentStrums.members[i].y = 50;
					game.opponentStrums.members[i].downScroll = false;
				}
				for (i in 0...game.playerStrums.length) game.playerStrums.members[i].y = 540;

				game.opponentStrums.members[0].x = 4;
				game.opponentStrums.members[1].x = 116;
				game.opponentStrums.members[2].x = 228;
				game.opponentStrums.members[3].x = 340;
				game.playerStrums.members[0].x = 825;
				game.playerStrums.members[1].x = 937;
				game.playerStrums.members[2].x = 1049;
				game.playerStrums.members[3].x = 1161;
				switched = true;
			}
			
			else if(PlayState.isMiddlescroll){
				for (i in 0...game.playerStrums.length) game.playerStrums.members[i].y = 530;//mid
				for (i in 0...game.opponentStrums.length) game.opponentStrums.members[i].alpha = 0;
			}
		}
		
		var daFrames:Float = (240/FlxG.updateFramerate);
		if(curBeat >= 808 && curBeat <= 872){
			reset += 0.006;
			hand.y += Math.cos(reset * daFrames) * 0.075 * daFrames;	
		}

		if(curStep >= 3488){
			reset += 0.002;
			gf.x += Math.cos(reset * daFrames) * 0.075 * daFrames;
			shadow.x += Math.cos(reset * daFrames) * 0.075 * daFrames;
		}
		
		if(curStep >= 3490){
			reset += 0.002;
			gf.y += Math.sin(reset * daFrames) * 0.075 * daFrames;
		}
	}

	// Steps, Beats and Sections:
	//    curStep, curDecStep
	//    curBeat, curDecBeat
	//    curSection
	override function stepHit()
	{
		// Code here
		if(curStep == 1594){
			missingnoEnter.animation.play('throw', true);
			missingnoEnter.alpha = 1;
		}//step 2373 beat 593
		if(curStep == 2373) for(i in 0...PlayState.instance.unspawnNotes.length -1) PlayState.instance.unspawnNotes[i].changeRGB();
		if(curStep == 2703) gf.alpha = 1;
	}
	var cameraTwn:FlxTween;
	override function beatHit()
	{
		// Code here
		//entering and leaving characters
		if(curBeat == 236){
			genEnter.animation.play('boo', true);
			genEnter.alpha = 1;
		}
		if(curBeat == 243){
			genEnter.alpha = 0;
			gf.alpha = 1;
		}
		if(curBeat == 400) missingnoEnter.animation.play('idle', true);
		if(curBeat == 410) missingnoEnter.animation.play('cracking', true);
		if(curBeat == 420) missingnoEnter.animation.play('breaking', true);
		if(curBeat == 427) missingnoEnter.animation.play('burst', true);
		if(curBeat == 432){
			missingnoEnter.alpha = 0;
			missingnoEnter.destroy();
			//bfDos.alpha = 1;
		}
		if(curBeat == 596){
			//FlxTween.tween(bfDos, {y: 1200}, 1.5, {onComplete: function(twn:FlxTween){}});
			gf.alpha = 0;
			genEnter.alpha = 1;
			genEnter.animation.play('bye', true);
		}
		if(curBeat == 599){
			genEnter.alpha = 0;
			genEnter.destroy();
		}
		//what to turn green
		if(curBeat == 600){
			gray1.color = 0xffb1ff81;
			gray2.color = 0xffb1ff81;
			gray3.color = 0xffb1ff81;
			FlxTween.tween(brimgraves, {alpha: 0}, 1, {onComplete: function(twn:FlxTween){}});
			FlxTween.tween(brimfloor, {alpha: 0}, 1, {onComplete: function(twn:FlxTween){}});
			FlxTween.tween(brimback, {alpha: 0}, 1, {onComplete: function(twn:FlxTween){}});

			if(!PlayState.isMiddlescroll){
				hud1.color = 0xffb1ff81;
				hud2.color = 0xffb1ff81;
			}
			else hud3.color = 0xffb1ff81;
			boyfriend.color = 0xff57b91a;
			dad.color = 0xff57b91a;
		
			for(i in 0...game.strumLineNotes.length){
				PlayState.instance.strumLineNotes.members[i].strumRGB();
				PlayState.instance.strumLineNotes.members[i].texture = 'noteSkins/NOTE_assets-buriedGB';
			}

			PlayState.colorChanged = true;
		}
		
		if(curBeat == 658) for(i in 0...PlayState.instance.unspawnNotes.length -1) PlayState.instance.unspawnNotes[i].changeRGB();

		if(curBeat == 664){
			FlxTween.tween(brimback, {alpha: 1}, 1, {onComplete: function(twn:FlxTween){}});
			FlxTween.tween(brimfloor, {alpha: 1}, 1, {onComplete: function(twn:FlxTween){}});
			FlxTween.tween(brimgraves, {alpha: 1}, 1, {onComplete: function(twn:FlxTween){
				gray1.color = FlxColor.WHITE;
				gray2.color = FlxColor.WHITE;
				gray3.color = FlxColor.WHITE;	
			}});
			if(!PlayState.isMiddlescroll){
				hud1.color = FlxColor.WHITE;
				hud2.color = FlxColor.WHITE;
			}
			else hud3.color = FlxColor.WHITE;
			
			for(i in 0...game.strumLineNotes.length){
				PlayState.instance.strumLineNotes.members[i].strumRGB();
				PlayState.instance.strumLineNotes.members[i].texture = 'noteSkins/NOTE_assets-buried';
			}
			boyfriend.color = FlxColor.WHITE;
			dad.color = FlxColor.WHITE;
		}
		if(curBeat == 676)gf.alpha = 1;

		//last bits
		if(curBeat == 743 || curBeat == 766 || curBeat == 826 || curBeat == 859){
			sludge.alpha = 1;
			sludge.animation.play(Std.string(FlxG.random.int(0, 2)), true);
		}
		if(curBeat == 748 || curBeat == 771 || curBeat == 831 || curBeat == 864){
			FlxTween.tween(sludge, {alpha: 0}, 3, {ease: FlxEase.sineIn, onComplete: function (twn:FlxTween) {
				cameraTwn = null;
			}});
		}
		if(curBeat == 808){
			hand.alpha = 1;
			shadow.alpha = 1;	
			hand.animation.play('hi', true);
		}
		if(curBeat == 812) hand.animation.play('idle', true);
		if(curBeat == 864){
			hand.animation.play('morph', true);
			FlxTween.tween(hand, {y: 420}, 2, {onComplete: function(twn:FlxTween){}});
			FlxTween.tween(shadow, {y: 700}, 2, {onComplete: function(twn:FlxTween){}});
			FlxTween.tween(FlxG.camera, {zoom: 1.94}, 2.8, {ease: FlxEase.sineIn, onComplete: function (twn:FlxTween) {
				defaultCamZoom = 1.94;
				cameraTwn = null;
			}});
		}
		if(curBeat == 868) gf.alpha = 0;
		if(curBeat == 872){
			hand.alpha = 0;
			gf.alpha = 1;
		}
		if(curBeat == 875)
			FlxTween.tween(FlxG.camera, {zoom: 0.94}, 2.8, {ease: FlxEase.linear, onComplete: function (twn:FlxTween) {
				defaultCamZoom = 0.94;
				cameraTwn = null;
			}});
		if(curBeat == 864){
			FlxTween.tween(brimback, {alpha: 0}, 2.5, {onComplete: function(twn:FlxTween){}});
			FlxTween.tween(brimfloor, {alpha: 0}, 2.5, {onComplete: function(twn:FlxTween){}});
			FlxTween.tween(brimgraves, {alpha: 0}, 2.5, {onComplete: function(twn:FlxTween){}});
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