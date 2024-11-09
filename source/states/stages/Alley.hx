package states.stages;

import states.stages.objects.*;

class Alley extends BaseStage
{
	// If you're moving your stage from PlayState to a stage file,
	// you might have to rename some variables if they're missing, for example: camZooming -> game.camZooming

	var alleywall:BGSprite;
	var alleyfloor:BGSprite;
	var jacket:BGSprite;
	var cameraTwn:FlxTween;
	override function create()
	{
		// Spawn your stage sprites here.
		// Characters are not ready yet on this function, so you can't add things above them yet.
		// Use createPost() if that's what you want to do.
		var bg:BGSprite = new BGSprite('alley_swag_wall', -870, -360, 0.9, 0.9, ['wal style change'], true);
		add(bg);
		var bg2:BGSprite = new BGSprite('alley_swag_ground', -600, -350, ['flo style change'], true);
		add(bg2);

		alleywall = new BGSprite('alleywall', -870, -360, 0.9, 0.9);
		add(alleywall);
		alleyfloor = new BGSprite('alleyground', -600, -350);
		add(alleyfloor);
	}
	
	override function createPost()
	{
		// Use this function to layer things above characters!
		jacket = new BGSprite('jacket', 450, 400);
		jacket.visible = false;
		add(jacket);
	}

	var skinName:String = objects.Note.defaultNoteSkin + objects.Note.getNoteSkinPostfix();
	override function stepHit()
	{
		// Code here
		if (curStep == 928)//Camera
			FlxTween.tween(FlxG.camera, {zoom: 1.3}, 2.5, {ease: FlxEase.sineIn, onComplete: function (twn:FlxTween) {
				cameraTwn = null;
			}});
		if(curStep == 934 || curStep == 1319){// Changes the notes to hit RGB to dark notes
			for(i in 0...PlayState.instance.unspawnNotes.length -1) 
				if(!PlayState.instance.unspawnNotes[i].gimmick) 
					PlayState.instance.unspawnNotes[i].changeRGB('dark');
		}
		if (curStep == 957){
			jacket.visible = true;
			FlxTween.tween(jacket, {x: 2500}, 0.15, {ease: FlxEase.linear, onComplete: function(twn:FlxTween) {
				jacket.visible = false;
			}});		
		}
		if (curStep == 960 || curStep == 1344){// Changes Strums to dark notes
			for(i in 0...game.strumLineNotes.length) PlayState.instance.strumLineNotes.members[i].texture = skinName + '-dark';
			alleywall.visible = false;
			alleyfloor.visible = false;
		}
		if(curStep == 1191 || curStep == 1447){//Normal
			for(i in 0...PlayState.instance.unspawnNotes.length -1) 
				if(!PlayState.instance.unspawnNotes[i].gimmick) 
					PlayState.instance.unspawnNotes[i].changeRGB();
		}
		if (curStep == 1216 || curStep == 1472){//Tis fine ig
			for(i in 0...game.strumLineNotes.length) PlayState.instance.strumLineNotes.members[i].texture = skinName;
			alleywall.visible = true;
			alleyfloor.visible = true;
		}
	}
}