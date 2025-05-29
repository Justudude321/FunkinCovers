package states.stages;

import states.stages.objects.*;

class Highschool extends BaseStage
{
	// If you're moving your stage from PlayState to a stage file,
	// you might have to rename some variables if they're missing, for example: camZooming -> game.camZooming

	var crowd:BGSprite;
	override function create()
	{
		// Spawn your stage sprites here.
		// Characters are not ready yet on this function, so you can't add things above them yet.
		// Use createPost() if that's what you want to do.
		var bg:BGSprite = new BGSprite('HighSchool', -600, 600);
		add(bg);
		var crowd:BGSprite = new BGSprite('gangbop', -400, 1450, ['Gang Bottom Boppers'], true);
		add(crowd);
		var floor:BGSprite = new BGSprite('barrera', -600, 2600);
		add(floor);
	}
	
    var strumStart:Float;
	override function createPost()
	{
		// Use this function to layer things above characters!
        strumStart = (ClientPrefs.data.downScroll) ? 570 : 50;
		for (i in 0...unspawnNotes.length)
			if(!unspawnNotes[i].mustPress) {
				unspawnNotes[i].texture = 'noteSkins/jenny';
				unspawnNotes[i].rgbShader.enabled = false;
			}
		for (i in 0...game.opponentStrums.length) {
			game.opponentStrums.members[i].set_texture('noteSkins/jenny');
			game.opponentStrums.members[i].useRGBShader = false;
		}
		gf.scrollFactor.set(1,1);
	}

	var a:Float = 0;
	override function update(elapsed:Float)
	{
		// Code here
		a += 4 * elapsed;
		for (i in 0...game.strumLineNotes.length)
            game.strumLineNotes.members[i].y = 20 * Math.cos(i/1.5 + a) + strumStart;
	}
}