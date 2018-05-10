local function init_cac_15_sa()
	local trip_mine_count = 0
	local target_count = 40
	local listener_key = {}

	local function on_trip_mine_placed_sa()
		if not Global.statistics_manager.playing_from_start then
			return
		end

		trip_mine_count = trip_mine_count + 1
		local num_plrs = managers.network:session():amount_of_players()
		target_count = math.min(num_plrs * 14, 40)

		if trip_mine_count == target_count then
			managers.achievment:award("cac_15")
		end
	end

	managers.player:register_message("trip_mine_placed", listener_key, on_trip_mine_placed_sa)
end

Hooks:PostHook(AchievmentManager, "init_cac_custom_achievements", "AchievmentManager_init_cac_custom_achievements_sa", function ()
    -- C-40
	init_cac_15_sa()
end)