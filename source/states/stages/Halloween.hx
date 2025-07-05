package states.stages;

import states.stages.objects.*;

class Halloween extends BaseStage
{
	// If you're moving your stage from PlayState to a stage file,
	// you might have to rename some variables if they're missing, for example: camZooming -> game.camZooming

	var boombox:BGSprite;
	override function create()
	{
		// Spawn your stage sprites here.
		// Characters are not ready yet on this function, so you can't add things above them yet.
		// Use createPost() if that's what you want to do.
		var bg:BGSprite = new BGSprite('spook', -800, -332);
		bg.setGraphicSize(Std.int(bg.width * 2));
		bg.updateHitbox();
		add(bg);

		boombox = new BGSprite('cd', 540, 588, ['boombox']);
		boombox.animation.addByPrefix('idle', 'boombox', 24, false);
		boombox.setGraphicSize(Std.int(boombox.width * 1.4));
		boombox.flipX = true;
		boombox.updateHitbox();
		add(boombox);
	}
	
	override function createPost()
	{
		// Use this function to layer things above characters!
		for(i in 0...game.strumLineNotes.length) 
			game.strumLineNotes.members[i].strumRGB('skarlet');
		for(i in 0...unspawnNotes.length) 
			unspawnNotes[i].changeRGB('skarlet');
		gf.scrollFactor.set(1,1);
	}

	override function update(elapsed:Float)
	{
		// Code here
        if(game.endingSong){
			camHUD.angle = 0;
			return;
		}
		var songPos:Float = Conductor.songPosition/1000;
		camHUD.angle = 1.25 * Math.cos(songPos);
	}

	// Steps, Beats and Sections:
	//    curStep, curDecStep
	//    curBeat, curDecBeat
	//    curSection
	override function beatHit()
	{
		// Code here
		boombox.animation.play("idle", true);
	}
}