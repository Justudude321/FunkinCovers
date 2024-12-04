-- e = 1
-- opponentmiss = 0
-- ranstoring = 0

-- --change the line below to the opponent miss animation name
-- local ame = {'singLEFTmiss', 'singDOWNmiss', 'singUPmiss', 'singRIGHTmiss'}
-- --miss volume
-- mvolume = 0.5
-- --miss chance
-- missc = 20

-- function onUpdatePost(elapsed)
--     for i = 0, getProperty('notes.length')-1 do
--         local strumTime = getPropertyFromGroup('notes', i, 'strumTime')
--         local distance = strumTime - getSongPosition();
--         data = getPropertyFromGroup('notes', i, 'noteData')
--         if getPropertyFromGroup('notes', i, 'mustPress') == false then
--             math.randomseed(strumTime)
--             noteran = math.random(1,missc) 
--             if ranstoring == 1 and distance >= 10 and distance <= 20 then
--                 setPropertyFromGroup('notes', i, 'ignoreNote', true) 
--                 playAnim('dad', ame[data+1], false)
--                 hpp = getProperty('health')
--                 setProperty('health',hpp + 0.023)
--                 opponentmiss = opponentmiss + 1
--                 playSound('missnote1',mvolume)
--             end
--         end
--     end
-- end


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
