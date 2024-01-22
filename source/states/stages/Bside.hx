package states.stages;

import states.stages.objects.*;

class Bside extends BaseStage
{
	override function create()
	{
		var bg:BGSprite = new BGSprite('stageback-B', -625, -280, 0.9, 0.9);
		add(bg);
		var stageFront:BGSprite = new BGSprite('stagefront-B', -810, 665, 0.9, 0.9);
		stageFront.setGraphicSize(Std.int(stageFront.width * 1.05));
		stageFront.updateHitbox();
		add(stageFront);
		
		if(!ClientPrefs.data.lowQuality) {
			var stageLight:BGSprite = new BGSprite('stage_light-B', -600, -240);
			add(stageLight);
			var stageCurtains:BGSprite = new BGSprite('stagecurtains-B', -800, -400);
			add(stageCurtains);
		}
	}
}