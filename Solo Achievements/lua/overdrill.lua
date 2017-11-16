function isHost()
	if not Network then return false end
	return not Network:is_client()
end

_toggleOverdrill = not _toggleOverdrill

if _toggleOverdrill then
	if managers.job:current_level_id() == "red2" and not managers.groupai:state():whisper_mode() and (Global.game_settings.difficulty == "overkill_290" or Global.game_settings.difficulty == "sm_wish") and isHost() then
		for _, script in pairs(managers.mission:scripts()) do
			for id, element in pairs(script:elements()) do
				for _, trigger in pairs(element:values().trigger_list or {}) do
					if trigger.notify_unit_sequence == "light_on" then
						element:on_executed()
						managers.chat:_receive_message(1, "Overdrill", "OK", Color.green) 
					end
				end
			end
		end
	else
		managers.chat:_receive_message(1, "Script Activated", "Conditions are not met!", Color.yellow)
		managers.chat:_receive_message(1, "Requirements", "Hosting a lobby, Deathwish Loud", Color.yellow)
	end
else
	managers.chat:_receive_message(1, "Script", "Deactivated", Color.red)
end