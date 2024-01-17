//@funkinScript
//I wonder if this was any better than the old camFollow with 5x2 if statements but eh
//Simple, changing the offset or multipling after speed in lerp makes it go faster/farther
//Sort of a combination of lua scripts turned into an HScript, the game.'s doesn't seem to affect it
//Originals made by Pumpsuki, Blue (bluecolorsin), and Mike (mike reference)

var focusOn:Character;
function onMoveCamera(focus:String){
	switch(focus){
		case 'boyfriend': focusOn = game.boyfriend;
		case 'dad': focusOn = game.dad;
		case 'gf': focusOn = game.gf;
	}
}

var axis:Bool;//true is vertical, false is horizontal
function onUpdatePost(dt){
	//Might need to uncomment this if you used isCameraOnForcedPos with onUpdate
	//game.isCameraOnForcedPos = false;
	var offset:Float = 30;//Probably not accurate idk
	var valid:Bool = true;
	
	switch(focusOn.animation.curAnim.name){
		case 'singUP':
			axis = true;
			offset *= -1;
		case 'singDOWN':
			axis = true;
		case 'singLEFT':
			axis = false;
			offset *= -1;
		case 'singRIGHT':
			axis = false;
		default://For anything that isn't singing, like idle
			valid = false;
	}

	if(valid){
		var oldPos:Float = (!axis) ? game.camGame.scroll.x : game.camGame.scroll.y;
		var newPos:Float = lerp(oldPos, oldPos + (1 / game.camGame.zoom * offset), dt * game.cameraSpeed * game.playbackRate * 1.2);
		if(!axis) game.camGame.scroll.x = newPos;
		else game.camGame.scroll.y = newPos;
	}
}

function lerp(start:Float, end:Float, speed:Float):Float{
	return start + (end - start) * speed;
}