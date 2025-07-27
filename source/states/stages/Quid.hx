package states.stages;

import states.stages.objects.*;
import objects.Note;
import shaders.Static;

class Quid extends BaseStage
{
	// If you're moving your stage from PlayState to a stage file,
	// you might have to rename some variables if they're missing, for example: camZooming -> game.camZooming

	var back:BGSprite;
	var front:BGSprite;
	var theHUD:FightHUD;
	var fight:BattleSystem;
	override function create()
	{
		// Spawn your stage sprites here.
		// Characters are not ready yet on this function, so you can't add things above them yet.
		// Use createPost() if that's what you want to do.
		var sky:BGSprite = new BGSprite('sky', -1150, -820, 0.1, 0.1);
		sky.setGraphicSize(Std.int(sky.width*1.1),Std.int(sky.height*1.1));
		sky.updateHitbox();
		add(sky);
		var backCity:BGSprite = new BGSprite('city_back', -800, -200, 0.15, 0.15);
		backCity.setGraphicSize(Std.int(backCity.width*1.1),Std.int(backCity.height*1.1));
		backCity.updateHitbox();
		add(backCity);
		var frontCity:BGSprite = new BGSprite('city_front', -840, 50, 0.2, 0.2);
		frontCity.setGraphicSize(Std.int(frontCity.width*1.1),Std.int(frontCity.height*1.1));
		frontCity.updateHitbox();
		add(frontCity);
		var nghq:BGSprite = new BGSprite('ng_hq', -680, -185, 0.3, 0.3);
		add(nghq);

		if(!ClientPrefs.data.lowQuality){
			back = new BGSprite('crowd_back', 0, 100, 0.85, 0.85, ['bop']);
			back.animation.addByPrefix('bop', 'bop', 24, false);
			back.setGraphicSize(Std.int(back.width*1.3),Std.int(back.height*1.2));
			back.updateHitbox();
			add(back);
		}

		var fg:BGSprite = new BGSprite('foreground', -780, 20, 0.95, 0.95);
		fg.setGraphicSize(Std.int(fg.width*1.2),Std.int(fg.height));
		fg.updateHitbox();
		add(fg);

		if(!ClientPrefs.data.lowQuality){
			front = new BGSprite('crowd_front', -240, 340, 0.95, 0.95, ['bop']);
			front.animation.addByPrefix('bop', 'bop', 24, false);
			add(front);
		}
		
		if(isStoryMode && !seenCutscene)
			setStartCallback(info);
	}
	
	var bias:Float = 5;
	override function createPost()
	{
		// Use this function to layer things above characters!
		theHUD = new FightHUD();
		add(theHUD);
		fight = new BattleSystem(theHUD);
		add(fight);

		var overlay:BGSprite = new BGSprite('overlay', -1280, -800, 0.5, 0.5);
		overlay.setGraphicSize(Std.int(overlay.width*1.1),Std.int(overlay.height*1.1));
		overlay.updateHitbox();
		overlay.blend = ADD;
		add(overlay);

		for (i in 0...unspawnNotes.length)
			if(!unspawnNotes[i].mustPress) {
				// Original oppMiss scripts from 7quid & .bakugo (Flowers Inside King)
				if(FlxG.random.bool(bias) && !unspawnNotes[i].isSustainNote && unspawnNotes[i].noteType != "Hey!"){
					unspawnNotes[i].noteType = "OppMiss Note";
					unspawnNotes[i].ignoreNote = true;
					bias = Math.max(bias - 5, 0);
					continue;
				}
				bias = Math.min(bias + 0.4, 15);
			}

        game.oppHitDrain = true;
		game.drainAmount = 0.012;
	}

	override function update(elapsed:Float)
	{
		// Code here
		if(input){
			if (FlxG.keys.justPressed.SPACE || FlxG.keys.justPressed.ENTER || FlxG.keys.justPressed.ESCAPE){
				input = false;
				light.alpha = 0.5;
				FlxTween.tween(tutorial, {alpha: 0}, 2, {ease: FlxEase.quartInOut});
				FlxTween.tween(light, {alpha: 0}, 2, {ease: FlxEase.cubeOut});
				tv.play(true);

				new FlxTimer().start(1, function(_) {
					inCutscene = false;
					FlxG.sound.music.fadeOut();
					FlxTween.tween(game.camHUD, {alpha: 1}, 2, {ease: FlxEase.cubeOut});
					startCountdown();
				});
			}
		}

		// if (fight != null) 
		// 	fight.update(elapsed);
	}

	override function countdownTick(count:Countdown, num:Int)
	{
		switch(count)
		{
			case THREE: //num 0
			case TWO: //num 1
			case ONE: //num 2
				theHUD.cameras = [camHUD];
				theHUD.readyHearts();
			case GO: //num 3
			case START: //num 4
		}
	}

	// Cutscene stuff
	var tv:FlxSound;
	var light:BGSprite;
	var tutorial:BGSprite;
	var input:Bool = false;
	function prepareCutscene(){
		inCutscene = true;
		camHUD.alpha = 0.00001;

		tutorial = new BGSprite('mouthman/intro/tutorial', 0, 0, ['default']);
		tutorial.animation.addByPrefix('default', 'default', 36.96, true);
		tutorial.alpha = 0.00001;
		tutorial.cameras = [camOther];
		tutorial.shader = new Static(); // Easier than I thought, still
		add(tutorial);
		light = new BGSprite('mouthman/intro/light', -260, -20, ['default']);
		light.animation.addByPrefix('default', 'default', 24, false);
		light.alpha = 0.00001;
		light.blend = ADD;
		light.cameras = [camOther];
		add(light);
	}
	
	function info(){
		prepareCutscene();

		Paths.sound('modstuff/mouthman/intro_tv');
		tv = new FlxSound().loadEmbedded(Paths.sound('modstuff/mouthman/intro_tv'));
		FlxG.sound.list.add(tv);

		new FlxTimer().start(1.5, function(_) {
            light.alpha = 1;
            light.animation.play("default", true);
			tv.play(true);

            new FlxTimer().start(0.5, function(_) {
                FlxG.sound.playMusic(Paths.sound("modstuff/mouthman/mouthman_tutorial"), 0.85, true);
                FlxTween.tween(light, {alpha: 0}, 2, {ease: FlxEase.cubeOut});
                tutorial.alpha = 1;
                tutorial.animation.play("default", true);
                input = true;
            });
        });
	}

	// Steps, Beats and Sections:
	//    curStep, curDecStep
	//    curBeat, curDecBeat
	//    curSection
	override function beatHit()
	{
		// Code here
		if(!ClientPrefs.data.lowQuality && curBeat % 2 == 0){
			back.animation.play("bop", true);
			front.animation.play("bop", true);
		}
		if (fight != null) 
			fight.beatHit();
	}

	// For events
	override function eventCalled(eventName:String, value1:String, value2:String, flValue1:Null<Float>, flValue2:Null<Float>, strumTime:Float)
	{
		switch(eventName)
		{
			case "battleEvent":
				fight.onEvent(value1, value2);
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

	override function opponentNoteHit(note:Note)
	{
		// Code here
		if(PlayState.instance.opponentVocals.volume == 0)
			PlayState.instance.opponentVocals.volume = 1;
	}
}