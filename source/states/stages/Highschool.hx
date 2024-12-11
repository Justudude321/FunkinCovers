package states.stages;

import states.stages.objects.*;
import objects.Character;

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
	
	override function createPost()
	{
		// Use this function to layer things above characters!
		for (i in 0...unspawnNotes.length)
			if(!unspawnNotes[i].mustPress) {
				unspawnNotes[i].texture = 'noteSkins/jenny';
				unspawnNotes[i].rgbShader.enabled = false;
			}
		for (i in 0...game.opponentStrums.length) {
			PlayState.instance.opponentStrums.members[i].texture = 'noteSkins/jenny';
			game.opponentStrums.members[i].useRGBShader = false;
		}
		gf.scrollFactor.set(1,1);
	}

	var singer:Character;
	function target() {
		if (game.gf != null && PlayState.SONG.notes[curSection].gfSection)
			singer = game.gf;
		else if (!PlayState.SONG.notes[curSection].mustHitSection)
			singer = game.dad;
		else
			singer = game.boyfriend;
	}

	var a:Float = 0;
	var offset:Float = 20;
	override function update(elapsed:Float)
	{
		// Code here
		a += 1/(FlxG.updateFramerate/4) * 1;

		if(PlayState.isDownscroll)
			for (i in 0...game.strumLineNotes.length)
				game.strumLineNotes.members[i].y = 20 * Math.cos(i/1.5 + a) + 570;
		else 
			for (i in 0...game.strumLineNotes.length)
				game.strumLineNotes.members[i].y = 20 * Math.cos(i/1.5 + a) + 50;
		
		target();
		switch(singer.animation.curAnim.name){
			case 'singLEFT':
				game.camGame.targetOffset.x = -offset;
				game.camGame.targetOffset.y = 0;
			case 'singDOWN':
				game.camGame.targetOffset.x = 0;
				game.camGame.targetOffset.y = offset;
			case 'singUP':
				game.camGame.targetOffset.x = 0;
				game.camGame.targetOffset.y = -offset;
			case 'singRIGHT':
				game.camGame.targetOffset.x = offset;
				game.camGame.targetOffset.y = 0;
			default://For anything that isn't singing, like idle
				game.camGame.targetOffset.x = 0;
				game.camGame.targetOffset.y = 0;
		}
	}
}