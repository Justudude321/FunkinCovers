package states.stages;

import states.stages.objects.*;
import objects.Note;

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

	var skinName:String = Note.defaultNoteSkin + Note.getNoteSkinPostfix();
	override function stepHit()
	{
		// Code here
        switch(curStep){
            case 928:// Camera zoom
                FlxTween.tween(FlxG.camera, {zoom: 1.3}, 2.5, {ease: FlxEase.sineIn, onComplete: 
                    function (twn:FlxTween) {cameraTwn = null;}
                });

            case 957:
                jacket.visible = true;
			    FlxTween.tween(jacket, {x: 2500}, 0.15, {ease: FlxEase.linear, onComplete: 
				function (twn:FlxTween) {jacket.visible = false;}});

            case 960:// Changes strums and notes RGB to dark notes, instantly :O
                for(i in 0...game.strumLineNotes.length)
                    game.strumLineNotes.members[i].set_texture(skinName + '-dark');
                for (i in 0...game.notes.members.length)
                    game.notes.members[i].changeRGB('dark');
                for(i in 0...unspawnNotes.length)
                    unspawnNotes[i].changeRGB('dark');

                alleywall.visible = false;
                alleyfloor.visible = false;

            case 1216:// Normal notes
                for(i in 0...game.strumLineNotes.length)
                    game.strumLineNotes.members[i].set_texture(skinName);
                for (i in 0...game.notes.members.length)
                    game.notes.members[i].changeRGB();
                for(i in 0...unspawnNotes.length)
                    unspawnNotes[i].changeRGB();

                alleywall.visible = true;
                alleyfloor.visible = true;

            case 1344:
                for(i in 0...game.strumLineNotes.length)
                    game.strumLineNotes.members[i].set_texture(skinName + '-dark');
                for (i in 0...game.notes.members.length)
                    game.notes.members[i].changeRGB('dark');
                for(i in 0...unspawnNotes.length)
                    unspawnNotes[i].changeRGB('dark');
                
                alleywall.visible = false;
                alleyfloor.visible = false;
                
            case 1472:// Weh, stupid notesplash is still dark when it updates >_<
                for(i in 0...game.strumLineNotes.length)
                    game.strumLineNotes.members[i].set_texture(skinName);
                for (i in 0...game.notes.members.length)
                    game.notes.members[i].changeRGB();
                for(i in 0...unspawnNotes.length)
                    unspawnNotes[i].changeRGB();

                alleywall.visible = true;
                alleyfloor.visible = true;
        }
	}
}