package states.stages;

import states.stages.objects.*;

class DriveThru extends BaseStage
{
	// If you're moving your stage from PlayState to a stage file,
	// you might have to rename some variables if they're missing, for example: camZooming -> game.camZooming

	override function create()
	{
		// Spawn your stage sprites here.
		// Characters are not ready yet on this function, so you can't add things above them yet.
		// Use createPost() if that's what you want to do.
		var bg:BGSprite = new BGSprite('DTbg', -100, -300, 0.8, 0.8);
		var madcar:BGSprite = new BGSprite('carbehind', 330, 200, 0.8, 0.8);
		var carback:BGSprite = new BGSprite('carback', 200, 200);
		add(bg);
		add(madcar);
		add(carback);
	}
	
	var switched:Bool = false;
	var newX:Array<Float> = new Array<Float>();
	override function createPost()
	{
		// Use this function to layer things above characters!
		var carfront:BGSprite = new BGSprite('carfront', -80, 150);
		add(carfront);

		if(!switched){
			for (i in 0...game.opponentStrums.length)
				newX[i] = game.opponentStrums.members[i].x;
			for (i in 0...game.opponentStrums.length)
				game.opponentStrums.members[i].x = game.playerStrums.members[i].x;
			for (i in 0...game.playerStrums.length)
				game.playerStrums.members[i].x = newX[i];

			switched = true;
		}
	}
	
	var guitarHero:Bool = ClientPrefs.data.guitarHeroSustains;
	override function opponentNoteHit(note:objects.Note)
	{
		// Code here
		game.health = !(guitarHero && note.isSustainNote) ? 
		Math.max(game.health - 0.015, 0.30) : game.health;
		PlayState.instance.iconP1.animation.curAnim.curFrame = 
		(game.health < 0.4) ? 1 : 0;
		PlayState.instance.iconP2.animation.curAnim.curFrame = 
		(game.health > 1.6) ? 1 : 0;
	}
}