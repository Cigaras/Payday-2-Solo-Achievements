core:module("CoreMissionManager")

Hooks:PreHook(MissionManager, "_add_script", "MissionManager__add_script_sa", function (self, data)
	--Pass the Ammo
	if managers.job:current_level_id() ~= "spa" then
		return
	end

	for k, v in pairs(data.elements) do
		if tostring(v.id) == "102000" then -- logic_counter_012
			v.values.counter_target = 2 + 2 * managers.network:session():amount_of_players()
			break
		end
	end
end)