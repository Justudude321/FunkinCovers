package states.stages;

import states.stages.objects.*;

class Subway2 extends BaseStage
{
	// If you're moving your stage from PlayState to a stage file,
	// you might have to rename some variables if they're missing, for example: camZooming -> game.camZooming

	var trainGroup:FlxSpriteGroup;
	var doors:BGSprite;
	override function create()
	{
		// Spawn your stage sprites here.
		// Characters are not ready yet on this function, so you can't add things above them yet.
		// Use createPost() if that's what you want to do.
		var bg:BGSprite = new BGSprite('BG_NEON', -483, -310, 0.9, 0.9, ['BACK'], true);
		bg.setGraphicSize(Std.int(bg.width*1.2),Std.int(bg.height*1.2));
		bg.updateHitbox();
		add(bg);

		trainGroup = new FlxSpriteGroup(-6100, 185);
		add(trainGroup);
		var train:BGSprite = new BGSprite('train');
		train.scale.set(1.2, 1.2);
		train.updateHitbox();
		trainGroup.add(train);

		var floor:BGSprite = new BGSprite('FRONT2', -483, -310, ['Floor front'], true);
		floor.setGraphicSize(Std.int(floor.width*1.2),Std.int(floor.height*1.2));
		floor.updateHitbox();
		add(floor);
		var floor2:BGSprite = new BGSprite('FRONT2', -483, -311 + floor.height, ['Floor front'], true);
		floor2.setGraphicSize(Std.int(floor2.width*1.2),Std.int(floor2.height*1.2));
		floor2.updateHitbox();
		floor2.flipY = true;
		add(floor2);
		var hat:BGSprite = new BGSprite('hat', 580, 658);
		hat.setGraphicSize(Std.int(hat.width*1.2),Std.int(hat.height*1.2));
		hat.updateHitbox();
		add(hat);
	}
	
	var boppers:BGSprite;
	override function createPost()
	{
		// Use this function to layer things above characters!
		boppers = new BGSprite('CROWD', -550, 350, ['crowd']);
		boppers.animation.addByPrefix('idle', 'crowd', 24, false);
		boppers.setGraphicSize(Std.int(boppers.width*1.2),Std.int(boppers.height*1.2));
		boppers.updateHitbox();
		add(boppers);

		for(i in 0...game.strumLineNotes.length) 
			game.strumLineNotes.members[i].strumRGB('skarlet');
		for(i in 0...unspawnNotes.length) 
			unspawnNotes[i].changeRGB('skarlet');
	}

	override function update(elapsed:Float)
	{
		// Code here
		var songPos:Float = Conductor.songPosition/1000;
		camHUD.angle = 2 * Math.sin(songPos);
	}

	override function beatHit()
	{
		// Code here
		boppers.animation.play("idle", true);
	}

	// For events
	var chance:Int = FlxG.random.int(1, 6);
	override function eventCalled(eventName:String, value1:String, value2:String, flValue1:Null<Float>, flValue2:Null<Float>, strumTime:Float)
	{
		switch(eventName)
		{
			case "Subway Train":
				switch (chance) {//"Borrowed" from a repository I found of V1 I think, sorry Rechi
					case 1:
						doors = new BGSprite('doors1', 2171, 58, ['DOORS OPENING']);
					case 2:
						doors = new BGSprite('doors2', 2486, 89, ['DOORS OPENING']);
					case 3:
						doors = new BGSprite('doors3', 2640, 158, ['DOORS OPENING']);
					case 4:
						doors = new BGSprite('doors4', 2485, 91, ['DOORS OPENING']);
					case 5:
						doors = new BGSprite('doors5', 2485, 91, ['DOORS OPENING']);
					case 6:
						doors = new BGSprite('doors6', 2485, 91, ['DOORS OPENING']);
				}
				doors.animation.addByPrefix('open', 'DOORS OPENING', 24, false);
				doors.animation.addByPrefix('close', 'DOORS CLOSING', 24, false);
				doors.animation.addByIndices('idle', 'DOORS OPENING', [0], "", 24, false);
				doors.animation.play('idle', true);
				doors.scale.set(1.2, 1.2);
				doors.updateHitbox();
				trainGroup.insert(0, doors);
				trainGroup.x = -6100;
				var tween1:FlxTween = FlxTween.tween(trainGroup, {x: -2100}, 5, {ease: FlxEase.cubeInOut,
					onComplete: function(_){
						var timer1:FlxTimer = new FlxTimer().start(0.75, function(_) {
							doors.animation.play('open');
							doors.animation.finishCallback = function(name:String) {
								if (name == "open") {
									var timer2:FlxTimer = new FlxTimer().start(1, function(_) {
										doors.animation.play('close');
										chance = ((chance + 1) % 6 == 0) ? 1 : chance + 1;
									});
								} else if (name == "close") {
									var timer3:FlxTimer = new FlxTimer().start(0.75, function(_) {
										var tween2:FlxTween = FlxTween.tween(trainGroup, {x: 3500}, 5, {ease: FlxEase.cubeInOut,
											onComplete: function(_){
												trainGroup.x = -6100;
												doors.destroy();
											}
										});
									});
								}
							}
						});
					}
				});
		}
	}
	override function eventPushed(event:objects.Note.EventNote)
	{
		// used for preloading assets used on events that doesn't need different assets based on its values
		switch(event.event)
		{
			case "Subway Train":
				Paths.image('doors' + chance);
				trace("Precached door " + chance);
				// No clue if this does anything or not
		}
	}
}