package states.stages;

import states.stages.objects.*;
import openfl.display.BlendMode;

class Plantroom extends BaseStage
{
	// If you're moving your stage from PlayState to a stage file,
	// you might have to rename some variables if they're missing, for example: camZooming -> game.camZooming
	
	var pinkVignette:BGSprite;
	var pinkVignette2:BGSprite;
	var heartsImage:BGSprite;
	var cloud1:BGSprite;
	var cloud2:BGSprite;
	var cloud3:BGSprite;
	var cloud4:BGSprite;
	var cloudbig:BGSprite;
	var greymira:BGSprite;
	var cyanmira:BGSprite;
	var oramira:BGSprite;
	var bluemira:BGSprite;
	var vignetteTween:FlxTween = null;
	override function create()
	{
		// Spawn your stage sprites here.
		// Characters are not ready yet on this function, so you can't add things above them yet.
		// Use createPost() if that's what you want to do.
		var bg:BGSprite = new BGSprite('bg sky', -1400, -800);
		bg.setGraphicSize(Std.int(bg.width * 1.05));
		bg.antialiasing = true;
		bg.active = false;
		add(bg);

		pinkVignette = new BGSprite('vignette', 0, 0);
		pinkVignette.cameras = [camOther];
		pinkVignette.alpha = 0;
		pinkVignette.antialiasing = true;
		pinkVignette.blend = ADD;

		pinkVignette2 = new BGSprite('vignette2', 0, 0);
		pinkVignette2.cameras = [camOther];
		pinkVignette2.antialiasing = true;
		pinkVignette2.alpha = 0;
		add(pinkVignette2);
		add(pinkVignette);

		heartsImage = new BGSprite('hearts', 25, 548, ['Symbol 2']);
		heartsImage.cameras = [camOther];
		heartsImage.animation.addByPrefix('boil', 'Symbol 2', 24, true);
		heartsImage.animation.play('boil');
		heartsImage.antialiasing = true;
		heartsImage.alpha = 0;
		add(heartsImage);

		var bg2:BGSprite = new BGSprite('cloud fathest', -1200, -100);
		bg2.antialiasing = true;
		bg2.active = false;
		add(bg2);

		var bg3:BGSprite = new BGSprite('cloud front', -1200, 0);
		bg3.antialiasing = true;
		bg3.active = false;
		add(bg3);

		cloud1 = new BGSprite('cloud 1', FlxG.random.int(-1900, 1300), -90);
		cloud1.antialiasing = true;
		add(cloud1);

		cloud2 = new BGSprite('cloud 2', FlxG.random.int(-1900, 1300), -150);
		cloud2.antialiasing = true;
		add(cloud2);

		cloud3 = new BGSprite('cloud 3', FlxG.random.int(-1900, 1300), -40);
		cloud3.antialiasing = true;
		add(cloud3);

		cloud4 = new BGSprite('cloud 4', FlxG.random.int(-1900, 1300), -435);
		cloud4.antialiasing = true;
		add(cloud4);

		cloudbig = new BGSprite('bigcloud', FlxG.random.int(-2600, 1200), -10);
		cloudbig.antialiasing = true;
		add(cloudbig);

		var bg4:BGSprite = new BGSprite('glasses', -1200, -750);
		bg4.antialiasing = true;
		bg4.active = false;
		add(bg4);

		greymira = new BGSprite('crew', -260, -75, ['grey']);
		greymira.animation.addByPrefix('bop', 'grey', 24, false);
		greymira.antialiasing = true;
		greymira.active = true;
		add(greymira);

		var bg5:BGSprite = new BGSprite('what is this', 0, -650);
		bg5.antialiasing = true;
		bg5.active = false;
		add(bg5);

		cyanmira = new BGSprite('crew', 740, -50, ['tomatomongus']);
		cyanmira.animation.addByPrefix('bop', 'tomatomongus', 24, false);
		cyanmira.antialiasing = true;
		cyanmira.active = true;
		add(cyanmira);

		oramira = new BGSprite('crew', 1000, 125, 1.2, 1, ['RHM']);
		oramira.animation.addByPrefix('bop', 'RHM', 24, false);
		oramira.antialiasing = true;
		oramira.active = true;
		add(oramira);

		var bg6:BGSprite = new BGSprite('lmao', -758, 117);
		bg6.antialiasing = true;
		bg6.setGraphicSize(Std.int(bg6.width * 0.9));
		bg6.active = false;
		add(bg6);
	}
	
	override function createPost()
	{
		// Use this function to layer things above characters!
		bluemira = new BGSprite('crew', -1300, 0, 1.2, 1, ['blue']);
		bluemira.animation.addByPrefix('bop', 'blue', 24, false);
		bluemira.antialiasing = true;
		bluemira.active = true;
		add(bluemira);
		
		var pot:BGSprite = new BGSprite('front pot', -1550, 650, 1.2, 1);
		pot.antialiasing = true;
		pot.setGraphicSize(Std.int(pot.width * 1));
		pot.active = false;
		add(pot);
		

		var vines:BGSprite = new BGSprite('vines', -1200, -1200, 1.4, 1, ['green']);
		vines.animation.addByPrefix('bop', 'green', 24, true);
		vines.animation.play('bop');
		vines.antialiasing = true;
		vines.active = true;
		add(vines);
	}

	override function update(elapsed:Float)
	{
		// Code here
		var daFrames:Float = (240/FlxG.updateFramerate);
		if(cloud1.x < -2400) cloud1.x = 1750;
		if(cloud2.x < -2400) cloud2.x = 1750;
		if(cloud3.x < -2400) cloud3.x = 1750;
		if(cloud4.x < -2400) cloud4.x = 1750;
		if(cloudbig.x < -3100) cloudbig.x = 1750;
		cloud1.x -= 0.05 * daFrames;
		cloud2.x -= 0.13 * daFrames;
		cloud3.x -= 0.1 * daFrames;
		cloud4.x -= 0.08 * daFrames;
		cloudbig.x -= 0.1 * daFrames;


		
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
		if ((curBeat >= 72 && curBeat <= 104) || (curBeat >= 136 && curBeat <= 168)){
			heartsImage.alpha = 1;
			if(curBeat == 72 || curBeat == 136)pinkVignette.alpha = 1;
			if (curBeat % 2 == 1){
				pinkVignette.alpha = 1;
				if(vignetteTween != null) vignetteTween.cancel();
				vignetteTween = FlxTween.tween(pinkVignette, {alpha: 0.2}, 1.2, {ease: FlxEase.sineOut});
			}
		}
		if(curBeat == 105 || curBeat == 169){
			pinkVignette.alpha = 1;
			FlxTween.tween(heartsImage, {alpha: 0}, 2.5, {ease: FlxEase.sineOut});
			if(vignetteTween != null) vignetteTween.cancel();
			vignetteTween = FlxTween.tween(pinkVignette, {alpha: 0}, 2.5, {ease: FlxEase.sineOut});
		}
		if(curBeat%2 == 0){
			cyanmira.animation.play('bop', true);
			greymira.animation.play('bop', true);
			oramira.animation.play('bop', true);
		}
		bluemira.animation.play('bop', true);
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