bopping = true

function onCreatePost()
	makeLuaSprite("sky", "7quid/sky", -1150, -820)
	scaleObject("sky", 1.1, 1.1)
	setScrollFactor("sky", 0.1, 0.1)
	addLuaSprite("sky", false)
	
	makeLuaSprite("city_back", "7quid/city_back", -800, -200)
	scaleObject("city_back", 1.1, 1.1)
	setScrollFactor("city_back", 0.15, 0.15)
	addLuaSprite("city_back", false)
	
	makeLuaSprite("city_front", "7quid/city_front", -840, 50)
	scaleObject("city_front", 1.1, 1.1)
	setScrollFactor("city_front", 0.2, 0.2)
	addLuaSprite("city_front", false)
	
	makeLuaSprite("ng_hq", "7quid/ng_hq", -680, -185)
	setScrollFactor("ng_hq", 0.3, 0.3)
	addLuaSprite("ng_hq", false)
	
	if not lowQuality then
		makeAnimatedLuaSprite("crowd_back", "7quid/crowd_back", 205, 110)
		addAnimationByPrefix("crowd_back", "bop", "bop", 24, false)
		scaleObject("crowd_back", 1.3, 1.2)
		setScrollFactor("crowd_back", 0.85, 0.85)
		addLuaSprite("crowd_back", false)
		playAnim("crowd_back", "bop", true)
	end
	
	makeLuaSprite("foreground", "7quid/foreground", -780, 20)
	scaleObject("foreground", 1.2, 1)
	setScrollFactor("foreground", 0.95, 0.95)
	addLuaSprite("foreground", false)
	
	if not lowQuality then
		local sperm = songName == "sperm"
		makeAnimatedLuaSprite("crowd_front", "7quid/crowd_front" .. (sperm and "_sperm" or ""), -400, sperm and 340 or 375)
		addAnimationByPrefix("crowd_front", "bop", "bop", 24, false)
		setScrollFactor("crowd_front", 0.95, 0.95)
		addLuaSprite("crowd_front", false)
		playAnim("crowd_front", "bop", true)
		
		makeLuaSprite("overlay", "7quid/overlay", -1280, -800)
		scaleObject("overlay", 1.1, 1.1)
		setScrollFactor("overlay", 0.5, 0.5)
		setBlendMode("overlay", "add")
		addLuaSprite("overlay", true)
	end
	
	if dadName == "binej" then
		setProperty("dad.x", getProperty("dad.x") - 80)
		setProperty("boyfriend.x", getProperty("boyfriend.x") - 80)
	end
end

if not lowQuality then
	function onCountdownTick(tick)
		if tick % 2 == 0 and bopping then 
			playAnim("crowd_back", "bop", true)
			playAnim("crowd_front", "bop", true)
		end
	end

	function onBeatHit()
		if curBeat % 2 == 0 and bopping then
			playAnim("crowd_back", "bop", true)
			playAnim("crowd_front", "bop", true)
		end
	end
end

-- crash prevention
function onUpdate() end
function onUpdatePost() end
