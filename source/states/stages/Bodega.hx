package states.stages;

import states.stages.objects.*;

class Bodega extends BaseStage
{
	// If you're moving your stage from PlayState to a stage file,
	// you might have to rename some variables if they're missing, for example: camZooming -> game.camZooming

	override function create()
	{
		// Spawn your stage sprites here.
		// Characters are not ready yet on this function, so you can't add things above them yet.
		// Use createPost() if that's what you want to do.
		var light:BGSprite = new BGSprite('light', -650, 600, 0.9, 0.9);
		var shop:BGSprite = new BGSprite('shop', -650, 600, 0.9, 0.9);
		var table:BGSprite = new BGSprite('table', -80, 1320, 0.9, 0.9);
		shop.setGraphicSize(Std.int(shop.width * 1.1), Std.int(shop.height * 1.1));
		shop.updateHitbox();

		add(light);
		add(shop);
		add(table);
	}

	var guitarHero:Bool = ClientPrefs.data.guitarHeroSustains;
	override function opponentNoteHit(note:objects.Note)
	{
		// Code here
		game.health = !(guitarHero && note.isSustainNote) ? 
		Math.max(game.health - 0.013, 0.30) : game.health;
		// Annoying that I have do this here	v
		PlayState.instance.iconP1.animation.curAnim.curFrame = 
		(game.health < 0.4) ? 1 : 0;
		PlayState.instance.iconP2.animation.curAnim.curFrame = 
		(game.health > 1.6) ? 1 : 0;
	}
}