package states.stages;

import states.stages.objects.*;
import objects.Note;

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
		camGame.bgColor.alphaFloat = 0.95;
		camGame.bgColor = FlxColor.WHITE;

		pokeBattle = new BGSprite('fondo_pokemon_1', -440, 260);
		pokeBattle.scale.set(1.55,1.8);
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

		if (!ClientPrefs.data.middleScroll){
			for (i in 0...game.opponentStrums.length){
				game.playerStrums.members[i].x = game.opponentStrums.members[i].x;
				game.opponentStrums.members[i].x = -200;			
			}
		}
	}

	override function beatHit()
	{
		// Code here
		if(curBeat == 128 || curBeat == 160 || curBeat == 264){
			pixelCharizard.visible = true;
			pixelPika.visible = true;
			charizard.visible = false;
			pika.visible = false;
			pokeBattle.visible = false;
		}
		if(curBeat == 144 || curBeat == 176 || curBeat == 316){
			pixelCharizard.visible = false;
			pixelPika.visible = false;
			charizard.visible = true;
			pika.visible = true;
			pokeBattle.visible = true;
		}
	}

	// Note Hit/Miss
	// Done this way so it doesn't take the pokemon too long to go back to bopping
	override function noteMiss(note:Note)
	{
		// Code here
		switch(note.noteType)
		{
			case 'Pika Note':
				if (!pixelPika.visible){
					pika.visible = false;
					var thunder:BGSprite = new BGSprite('pikachu', pika.x, pika.y, ['pikaatack']);
					thunder.animation.addByPrefix('pow','pikaatack',24,false);
					addBehindBF(thunder);
					thunder.animation.play('pow');
					thunder.animation.finishCallback = function(name:String){
						thunder.destroy();
						pika.visible = true;	
					}
				}
			case 'Fuego Note':
				if (!pixelCharizard.visible){
					charizard.visible = false;
					var fire:BGSprite = new BGSprite('charizard', -50, 15, ['charizard atack']);
					fire.animation.addByPrefix('pow','charizard atack',24,false);
					addBehindDad(fire);
					fire.animation.play('pow');
					fire.animation.finishCallback = function(name:String){
						fire.destroy();
						charizard.visible = true;	
					}
				}
		}
	}
}