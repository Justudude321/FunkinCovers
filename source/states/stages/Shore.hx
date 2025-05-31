package states.stages;

import states.stages.objects.*;

class Shore extends BaseStage
{
	// If you're moving your stage from PlayState to a stage file,
	// you might have to rename some variables if they're missing, for example: camZooming -> game.camZooming

	override function create()
	{
		// Spawn your stage sprites here.
		// Characters are not ready yet on this function, so you can't add things above them yet.
		// Use createPost() if that's what you want to do.
		var sky:BGSprite = new BGSprite('scourgesky', -900, -650, 0.5, 1.0);
		sky.setGraphicSize(Std.int(sky.width * 1.5), Std.int(sky.height * 1.5));
		sky.updateHitbox();
		add(sky);
		var cliffs:BGSprite = new BGSprite('scourgecliffs', -900, -318, 0.7, 1.0);
		cliffs.setGraphicSize(Std.int(cliffs.width * 1.5), Std.int(cliffs.height * 1.5));
		cliffs.updateHitbox();
		add(cliffs);
		var sea:BGSprite = new BGSprite('scourgesea', -900, 250);
		sea.setGraphicSize(Std.int(sea.width * 1.5), Std.int(sea.height * 1.5));
		sea.updateHitbox();
		add(sea);
		var ground:BGSprite = new BGSprite('scourgeground', -900, 507);
		ground.setGraphicSize(Std.int(ground.width * 1.5), Std.int(ground.height * 1.5));
		ground.updateHitbox();
		add(ground);
	} // offset of 30 for camfollow notes
}