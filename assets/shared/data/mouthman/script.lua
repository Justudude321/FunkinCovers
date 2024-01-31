-- local step_stuff = {
-- 	[504] = function()
-- 		callScript("scripts/neocam", "focus", {"dad", 1.25, "cubeout"})
		
-- 		playAnim("dad", "hey", true)
-- 		setProperty("dad.specialAnim", true)
-- 	end,
	
-- 	[508] = function()
-- 		playAnim("dad", "hey", true)
-- 		setProperty("dad.specialAnim", true)
-- 	end,
	
-- 	[2008] = function()
-- 		setProperty("dad.alpha", 0.0001)
		
-- 		setProperty("binej.alpha", 1)
-- 		playAnim("binej", "spit", true)
-- 	end,
	
-- 	[2010] = function()
-- 		playAnim("binej", "spit", true)
-- 	end,
	
-- 	[2016] = function()
-- 		setProperty("dad.alpha", 1)
		
-- 		setProperty("binej.alpha", 0.0001)
-- 	end
-- }
-- function onStepHit() if step_stuff[curStep] then step_stuff[curStep]() end end

-- -- crash prevention
-- function onUpdate() end
