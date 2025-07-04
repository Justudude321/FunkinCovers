package states.stages;

import states.stages.objects.*;

class Cupstage extends BaseStage
{
	// If you're moving your stage from PlayState to a stage file,
	// you might have to rename some variables if they're missing, for example: camZooming -> game.camZooming

	override function create()
	{
		// Spawn your stage sprites here.
		// Characters are not ready yet on this function, so you can't add things above them yet.
		// Use createPost() if that's what you want to do.
		var sky:BGSprite = new BGSprite('BG-00', -730, -280, 0.7, 0.7);
		sky.setGraphicSize(Std.int(sky.width*4),Std.int(sky.height*4));
		sky.updateHitbox();
		add(sky);
		var bg:BGSprite = new BGSprite('BG-01', -700, -520, 0.8, 0.8);
		bg.setGraphicSize(Std.int(bg.width*4),Std.int(540*4));
		bg.updateHitbox();
		add(bg);
		var fg:BGSprite = new BGSprite('BG-02', -700, -565);
		fg.setGraphicSize(Std.int(fg.width*4),Std.int(fg.height*4));
		fg.updateHitbox();
		add(fg);
		
		var grain = new BGSprite('Grainshit', 0, 0, ['Geain instance 1'], true);
		grain.cameras = [camOther];
		add(grain);
		var effects = new BGSprite('CUpheqdshid', 0, 0, ['Cupheadshit_gif instance 1'], true);
		effects.cameras = [camOther];
		add(effects);
	}
	
	override function createPost()
	{
		// Use this function to layer things above characters!
		for(i in 0...unspawnNotes.length) 
			unspawnNotes[i].changeRGB('cross');
	}
}