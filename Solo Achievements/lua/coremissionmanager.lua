core:module("CoreMissionManager")

Hooks:PreHook(MissionManager, "_add_script", "MissionManager__add_script_sa", function(self, data)
	--Pass the Ammo
	if managers.job:current_level_id() ~= "spa" then
		return
	end

	for k, v in pairs(data.elements) do
		if v.editor_name == "logic_counter_012" then
			v.values.counter_target = 2 + 2 * managers.network:session():amount_of_players()
			return
		end
	end
end)