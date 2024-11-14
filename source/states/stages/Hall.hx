package states.stages;

import states.stages.objects.*;
import shaders.Hallway;

class Hall extends BaseStage
{
	// If you're moving your stage from PlayState to a stage file,
	// you might have to rename some variables if they're missing, for example: camZooming -> game.camZooming

	override function create()
	{
		// Spawn your stage sprites here.
		// Characters are not ready yet on this function, so you can't add things above them yet.
		// Use createPost() if that's what you want to do.
		var bg:BGSprite = new BGSprite('NikusaBG', -1000, -425);
		add(bg);
	}

	override function createPost()
	{
		// Use this function to layer things above characters!
		boyfriend.shader = new Hallway();

		for(i in 0...unspawnNotes.length)
			unspawnNotes[i].changeRGB('entity');
		for(i in 0...game.strumLineNotes.length)
			game.strumLineNotes.members[i].strumRGB('entity');
	}
	
	var guitarHero:Bool = ClientPrefs.data.guitarHeroSustains;
	override function opponentNoteHit(note:objects.Note)
	{
		// Code here
		game.health = !(guitarHero && note.isSustainNote) ? 
		Math.max(game.health - 0.018, 0.30) : game.health;
		PlayState.instance.iconP1.animation.curAnim.curFrame = 
		(game.health < 0.4) ? 1 : 0;
		PlayState.instance.iconP2.animation.curAnim.curFrame = 
		(game.health > 1.6) ? 1 : 0;
	}
}