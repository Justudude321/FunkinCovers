function onCreatePost()
	setPropertyFromClass("GameOverSubstate", "loopSoundName", "binej_game_over_loop")
	setPropertyFromClass("GameOverSubstate", "endSoundName", "binej_game_over_confirm")
	
	if not lowQuality then
		precacheSound("binej_game_over_loop")
		precacheSound("binej_game_over_confirm")
	end
end

-- crash prevention
function onUpdate() end
function onUpdatePost() end
