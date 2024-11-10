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
	}

	override function update(elapsed:Float)
	{
		// Code here
		if(curStep == 0){
			for(i in 0...game.strumLineNotes.length) PlayState.instance.strumLineNotes.members[i].strumRGB('entity');
			for(i in 0...PlayState.instance.unspawnNotes.length) PlayState.instance.unspawnNotes[i].changeRGB('entity');
		}
	}
	
	var guitarHero:Bool = ClientPrefs.data.guitarHeroSustains;
	override function opponentNoteHit(note:objects.Note)
	{
		// Code here
		PlayState.instance.health = !(guitarHero && note.isSustainNote) ? 
		Math.max(PlayState.instance.health - 0.02, 0.30) : PlayState.instance.health;
	}
}