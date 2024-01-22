local combo = -40

function onCreatePost()
	setPropertyFromClass("GameOverSubstate", "loopSoundName", "binej_game_over_loop")
	setPropertyFromClass("GameOverSubstate", "endSoundName", "binej_game_over_confirm")
	
	if not lowQuality then
		precacheSound("binej_game_over_loop")
		precacheSound("binej_game_over_confirm")
	end
end

function opponentNoteHit(id, dir, note_type, sustained)
	combo = combo + 1
	if getHealth() >= 0.015 then
		local multiplier = not sustained and 0.81 or 0.7
		
		if combo > 25 and getRandomInt(15, combo * 16) < combo and not sustained then
			multiplier = 0.3
			combo = getRandomInt(-5, 15)
		end
		
		addHealth(-2 / (crochet * multiplier))
    end
end

-- crash prevention
function onUpdate() end
function onUpdatePost() end
