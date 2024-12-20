package states.stages;

import substates.GameOverSubstate;
import states.stages.objects.*;

import objects.Note;

enum NeneState2
{
	STATE_DEFAULT;
	STATE_PRE_RAISE;
	STATE_RAISE;
	STATE_READY;
	STATE_LOWER;
}

class Funkg extends BaseStage
{
	final MIN_BLINK_DELAY:Int = 3;
	final MAX_BLINK_DELAY:Int = 7;
	final VULTURE_THRESHOLD:Float = 0.5;
	var blinkCountdown:Int = 3;

	var abot:ABotSpeaker;
	override function create()
	{
		var buildings:BGSprite = new BGSprite('april_bg_1', -816, -280, 0.54, 1.0);
		add(buildings);
		var floor:BGSprite = new BGSprite('april_bg_2', -1053, -325, 0.99, 1.0);
		add(floor);
		var walls:BGSprite = new BGSprite('april_bg_3', -624, -325, 0.96, 1.0);
		add(walls);
		var vm:BGSprite = new BGSprite('april_bg_4', -643, -142, 0.93, 1.0);
		add(vm);

		abot = new ABotSpeaker(gfGroup.x - 50, gfGroup.y + 526);
		updateABotEye(true);
		add(abot);

		var _song = PlayState.SONG;
		if(_song.gameOverSound == null || _song.gameOverSound.trim().length < 1) GameOverSubstate.deathSoundName = 'fnf_loss_sfx-picoo';
		if(_song.gameOverLoop == null || _song.gameOverLoop.trim().length < 1) GameOverSubstate.loopSoundName = 'gameOver-pico';
		if(_song.gameOverEnd == null || _song.gameOverEnd.trim().length < 1) GameOverSubstate.endSoundName = 'gameOverEnd-pico';
		if(_song.gameOverChar == null || _song.gameOverChar.trim().length < 1) GameOverSubstate.characterName = 'picoo-dead';
		setDefaultGF('nene');
	}

	override function createPost()
	{
		var fg:BGSprite = new BGSprite('april_bg_5', -1376, 365, 1.14, 1.0);
		add(fg);
		gfGroup.scrollFactor.set(0.98, 0.98);

		if(gf != null)
		{
			gf.animation.callback = function(name:String, frameNumber:Int, frameIndex:Int)
			{
				switch(currentNeneState)
				{
					case STATE_PRE_RAISE:
						if (name == 'danceLeft' && frameNumber >= 14)
						{
							animationFinished = true;
							transitionState();
						}
					default:
						// Ignore.
				}
			}
		}
	}

	function updateABotEye(finishInstantly:Bool = false)
	{
		if(PlayState.SONG.notes[Std.int(FlxMath.bound(curSection, 0, PlayState.SONG.notes.length - 1))].mustHitSection == true)
			abot.lookRight();
		else
			abot.lookLeft();

		if(finishInstantly) abot.eyes.anim.curFrame = abot.eyes.anim.length - 1;
	}

	override function startSong()
	{
		abot.snd = FlxG.sound.music;
		gf.animation.finishCallback = onNeneAnimationFinished;
	}
	
	function onNeneAnimationFinished(name:String)
	{
		if(!game.startedCountdown) return;

		switch(currentNeneState)
		{
			case STATE_RAISE, STATE_LOWER:
				if (name == 'raiseKnife' || name == 'lowerKnife')
				{
					animationFinished = true;
					transitionState();
				}

			default:
				// Ignore.
		}
	}
	
	var currentNeneState:NeneState2 = STATE_DEFAULT;
	var animationFinished:Bool = false;
	override function update(elapsed:Float)
	{
		
		if(gf == null || !game.startedCountdown) return;

		animationFinished = gf.isAnimationFinished();
		transitionState();
	}

	function transitionState()
	{
		switch (currentNeneState)
		{
			case STATE_DEFAULT:
				if (game.health <= VULTURE_THRESHOLD)
				{
					currentNeneState = STATE_PRE_RAISE;
					gf.skipDance = true;
				}

			case STATE_PRE_RAISE:
				if (game.health > VULTURE_THRESHOLD)
				{
					currentNeneState = STATE_DEFAULT;
					gf.skipDance = false;
				}
				else if (animationFinished)
				{
					currentNeneState = STATE_RAISE;
					gf.playAnim('raiseKnife');
					gf.skipDance = true;
					gf.danced = true;
					animationFinished = false;
				}

			case STATE_RAISE:
				if (animationFinished)
				{
					currentNeneState = STATE_READY;
					animationFinished = false;
				}

			case STATE_READY:
				if (game.health > VULTURE_THRESHOLD)
				{
					currentNeneState = STATE_LOWER;
					gf.playAnim('lowerKnife');
				}

			case STATE_LOWER:
				if (animationFinished)
				{
					currentNeneState = STATE_DEFAULT;
					animationFinished = false;
					gf.skipDance = false;
				}
		}
	}

	override function sectionHit()
	{
		updateABotEye();
	}

	override function beatHit()
	{
		//if(curBeat % 2 == 0) abot.beatHit();
		switch(currentNeneState) {
			case STATE_READY:
				if (blinkCountdown == 0)
				{
					gf.playAnim('idleKnife', false);
					blinkCountdown = FlxG.random.int(MIN_BLINK_DELAY, MAX_BLINK_DELAY);
				}
				else blinkCountdown--;

			default:
				// In other states, don't interrupt the existing animation.
		}
	}
	
	override function goodNoteHit(note:Note)
	{
		// 10% chance of playing combo50/combo100 animations for Nene
		if(FlxG.random.bool(10))
		{
			switch(game.combo)
			{
				case 50, 100:
					var animToPlay:String = 'combo${game.combo}';
					if(gf.animation.exists(animToPlay))
					{
						gf.playAnim(animToPlay);
						gf.specialAnim = true;
					}
			}
		}
	}
}