package states.stages;

import states.stages.objects.*;

class Dside extends BaseStage
{
	override function create()
	{
		var bg:BGSprite = new BGSprite('stageback-D', -600, -200, 0.9, 0.9);
		add(bg);
		var stageFront:BGSprite = new BGSprite('stagefront-D', -650, 600, 0.9, 0.9);
		stageFront.setGraphicSize(Std.int(stageFront.width * 1.1));
		stageFront.updateHitbox();
		add(stageFront);
	}
}