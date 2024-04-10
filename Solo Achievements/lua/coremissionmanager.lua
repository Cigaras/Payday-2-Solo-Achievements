core:module("CoreMissionManager")

local missions = {
	["cage"] = {
		-- Tag, You're it!
		[101487] = function(element) -- only_4man_players
			element.values.player_1 = true
		end,
	},
	["spa"] = {
		-- Pass the Ammo
		[102000] = function(element) -- logic_counter_012
			element.values.counter_target = 2 + 2 * managers.network:session():amount_of_players()
		end,
	},
}

Hooks:PreHook(MissionManager, "_add_script", "MissionManager__add_script_sa", function(self, data)
	local filter_data = missions[managers.job:current_level_id()]
	if not filter_data then
		return
	end

	local matches = 0
	local n_filters = table.size(filter_data)
	for _, element in pairs(data.elements) do
		local element_filter = filter_data[element.id]
		if element_filter then -- our filter passed, patch element data
			element_filter(element)
			matches = matches + 1
		end

		if matches == n_filters then -- we are done with patching, exit loop
			break
		end
	end
end)
