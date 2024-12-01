package states.stages;

import states.stages.objects.*;

class Rivalarena extends BaseStage
{
	// If you're moving your stage from PlayState to a stage file,
	// you might have to rename some variables if they're missing, for example: camZooming -> game.camZooming

	override function create()
	{
		// Spawn your stage sprites here.
		// Characters are not ready yet on this function, so you can't add things above them yet.
		// Use createPost() if that's what you want to do.
		var bg:BGSprite = new BGSprite('Bg', -75, 200);
		bg.setGraphicSize(Std.int(bg.width*0.5),Std.int(bg.height*0.5));
		bg.updateHitbox();
		add(bg);
	}
	
	override function createPost()
	{
		// Use this function to layer things above characters!
		var table:BGSprite = new BGSprite('Table', 1130, 200);
		table.setGraphicSize(Std.int(table.width*0.5),Std.int(table.height*0.5));
		table.updateHitbox();
		add(table);
	}
}