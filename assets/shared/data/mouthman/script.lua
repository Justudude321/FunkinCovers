local stop_countdown = true
local input = false

function onCreatePost()
	if isStoryMode and not seenCutscene then
		makeAnimatedLuaSprite("tutorial", "mouthman/intro/tutorial", 0, 0)
		addAnimationByPrefix("tutorial", "default", "default", 36.96, true)
		setProperty("tutorial.alpha", 0.00001)
		setObjectCamera("tutorial", "other")
		addLuaSprite("tutorial", true)
		
		makeAnimatedLuaSprite("light", "mouthman/intro/light", -260, -20)
		addAnimationByPrefix("light", "default", "default", 24, false)
		setProperty("light.alpha", 0.00001)
		setBlendMode("light", "add")
		setObjectCamera("light", "other")
		addLuaSprite("light", true)
		
		if not lowQuality then
			initLuaShader("static")
			setSpriteShader("tutorial", "static")
			setShaderFloat("tutorial", "u_elapsed", 0)
			setShaderFloat("tutorial", "u_alpha", 1)
		end
		
		setProperty("camHUD.alpha", 0.0001)
	end
end

function onStartCountdown()
	if isStoryMode and stop_countdown and not seenCutscene then
		setProperty("inCutscene", true)
		
		runTimer("tutorial", 1.5)
		
		return Function_Stop
	end
	
	return Function_Continue
end

local timer_stuff = {
	tutorial = function()
		setProperty("light.alpha", 1)
		playAnim("light", "default", true)
		
		playSound("mouthman/intro_tv")
		
		runTimer("opened", 12 / 24)
	end,
	
	opened = function()
		doTweenAlpha("light_fadeout", "light", 0, 2, "cubeout")
		
		setProperty("tutorial.alpha", 1)
		playAnim("tutorial", "default", true)
		
		input = true
		
		playMusic("mouthman_tutorial", 0.75, true)
	end,
	
	closed = function()
		stop_countdown = false
		
		setProperty("inCutscene", false)
		runHaxeCode("game.startCountdown();")
		
		doTweenAlpha("hud_fadein", "camHUD", 1, 2, "cubeout")
	end
}
function onTimerCompleted(tag) if timer_stuff[tag] then timer_stuff[tag]() end end

function onUpdatePost(elapsed)
	if isStoryMode and stop_countdown and not seenCutscene then
		if input then
			for _, key in pairs({"SPACE", "ENTER", "ESCAPE"}) do
				if getPropertyFromClass("flixel.FlxG", "keys.justPressed." .. key) then
					input = false
					
					doTweenAlpha("tutorial_fadeout", "tutorial", 0, 2, "quartinout")
					
					setProperty("light.alpha", 0.5)
					doTweenAlpha("light_fadeout", "light", 0, 2, "cubeout")
					
					playSound("confirmMenu")
					soundFadeOut("", 1.5)
					
					runTimer("closed", 1)
				end
			end
		end
		
		if not lowQuality then
			setShaderFloat("tutorial", "u_elapsed", getShaderFloat("tutorial", "u_elapsed") + elapsed)
		end
	end
end

local step_stuff = {
	[504] = function()
		callScript("scripts/neocam", "focus", {"dad", 1.25, "cubeout"})
		
		playAnim("dad", "hey", true)
		setProperty("dad.specialAnim", true)
	end,
	
	[508] = function()
		playAnim("dad", "hey", true)
		setProperty("dad.specialAnim", true)
	end,
	
	[2008] = function()
		setProperty("dad.alpha", 0.0001)
		
		setProperty("binej.alpha", 1)
		playAnim("binej", "spit", true)
	end,
	
	[2010] = function()
		playAnim("binej", "spit", true)
	end,
	
	[2016] = function()
		setProperty("dad.alpha", 1)
		
		setProperty("binej.alpha", 0.0001)
	end
}
function onStepHit() if step_stuff[curStep] then step_stuff[curStep]() end end

-- crash prevention
function onUpdate() end
