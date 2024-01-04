package states.stages;

import states.stages.objects.*;

class Redstage extends BaseStage
{
	// If you're moving your stage from PlayState to a stage file,
	// you might have to rename some variables if they're missing, for example: camZooming -> game.camZooming

	var pokeBattle:BGSprite;
	var charizard:BGSprite;
	var pixelCharizard:BGSprite;
	var pika:BGSprite;
	var pixelPika:BGSprite;
	override function create()
	{
		// Spawn your stage sprites here.
		// Characters are not ready yet on this function, so you can't add things above them yet.
		// Use createPost() if that's what you want to do.
		var bg1:BGSprite = new BGSprite('camFlash', -200, 400);
		bg1.scale.set(2.3,2.3);
		add(bg1);
		pokeBattle = new BGSprite('fondo_pokemon_1', -440, 310);
		pokeBattle.scale.set(1.55,1.55);
		add(pokeBattle);

		charizard = new BGSprite('charizard', 400, 50, ['chari idle']);
		charizard.animation.addByPrefix('idle', 'chari idle', 22);
		add(charizard);
		pixelCharizard = new BGSprite('pixelcharizard', 550, 200, ['chari idle'], true);
		add(pixelCharizard);
		
		charizard.animation.play("idle");
		pixelCharizard.visible = false;
	}
	
	override function createPost()
	{
		// Use this function to layer things above characters!
		pika = new BGSprite('pikachu', 1200, 600, ['PIKACHU IDLE']);
		pika.animation.addByPrefix('idle', 'PIKACHU IDLE', 22);
		add(pika);
		pixelPika = new BGSprite('pixelpikachu', 1200, 600, ['pikachu idle'], true);
		add(pixelPika);
		pika.animation.play("idle");
		pixelPika.visible = false;
	}

	var switched:Bool = false;
	override function update(elapsed:Float)
	{
		// Code here
		if(PlayState.instance.pikaAtk == true && !pixelPika.visible){
			pika.visible = false;
			var thunder:BGSprite = new BGSprite('pikachu', pika.x, pika.y, ['pikaatack']);
			thunder.animation.addByPrefix('pow','pikaatack',24,false);
			addBehindBF(thunder);
			thunder.animation.play('pow');
			thunder.animation.finishCallback = function(name:String){
				thunder.destroy();
				pika.visible = true;	
			}
			PlayState.instance.pikaAtk = false;
		}
		if(PlayState.instance.fuegoAtk && !pixelCharizard.visible){
			charizard.visible = false;
			var fire:BGSprite = new BGSprite('charizard', -50, 15, ['charizard atack']);
			fire.animation.addByPrefix('pow','charizard atack',24,false);
			addBehindDad(fire);
			fire.animation.play('pow');
			fire.animation.finishCallback = function(name:String){
				fire.destroy();
				charizard.visible = true;	
			}
			PlayState.instance.fuegoAtk = false;
		}

		if(!switched){
			for (i in 0...game.opponentStrums.length)game.opponentStrums.members[i].x = -200;
			if(!PlayState.isMiddlescroll){
				game.playerStrums.members[0].x = 92;
				game.playerStrums.members[1].x = 204;
				game.playerStrums.members[2].x = 316;
				game.playerStrums.members[3].x = 428;
			}
			switched = true;
		}
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
		if(curBeat == 128 || curBeat == 160 || curBeat == 264){
			PlayState.instance.pixelsNow = true;
			pixelCharizard.visible = true;
			pixelPika.visible = true;
			charizard.visible = false;
			pika.visible = false;
			pokeBattle.visible = false;
		}
		if(curBeat == 144 || curBeat == 176 || curBeat == 316){
			PlayState.instance.pixelsNow = false;
			pixelCharizard.visible = false;
			pixelPika.visible = false;
			charizard.visible = true;
			pika.visible = true;
			pokeBattle.visible = true;
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