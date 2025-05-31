package states.stages;

import states.stages.objects.*;

class NeonAlley extends BaseStage
{
	// If you're moving your stage from PlayState to a stage file,
	// you might have to rename some variables if they're missing, for example: camZooming -> game.camZooming

	override function create()
	{
		// Spawn your stage sprites here.
		// Characters are not ready yet on this function, so you can't add things above them yet.
		// Use createPost() if that's what you want to do.
        var back:BGSprite = new BGSprite('back', -850, -300);
		back.setGraphicSize(Std.int(back.width*1.2),Std.int(back.height*1.2));
		back.updateHitbox();
        var neon:BGSprite = new BGSprite('neon', -250, -300, ['neon_tick'], true);
		neon.setGraphicSize(Std.int(neon.width*1.2),Std.int(neon.height*1.2));
		neon.updateHitbox();
        neon.blend = SCREEN;
        
		add(back);
		add(neon);
	}
	
	override function createPost()
	{
		// Use this function to layer things above characters!
        var lightA:BGSprite = new BGSprite('blend_02', -850, -300);
		lightA.setGraphicSize(Std.int(lightA.width*1.2),Std.int(lightA.height*1.2));
		lightA.updateHitbox();
        lightA.blend = MULTIPLY;
        var lightB:BGSprite = new BGSprite('blend_01', -850, -300);
		lightB.setGraphicSize(Std.int(lightB.width*1.2),Std.int(lightB.height*1.2));
		lightB.updateHitbox();
        lightB.blend = SCREEN;
        var front:BGSprite = new BGSprite('front', -850, -300, 0.8, 0.8);
		front.setGraphicSize(Std.int(front.width*1.2),Std.int(front.height*1.2));
		front.updateHitbox();
		add(lightA);
		add(lightB);
		add(front);

        for(i in 0...unspawnNotes.length)
			unspawnNotes[i].changeRGB('doki');
		for(i in 0...game.strumLineNotes.length)
			game.strumLineNotes.members[i].strumRGB('doki');
	}
}