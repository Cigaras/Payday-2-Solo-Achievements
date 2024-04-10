local hook_id = "AchievmentManager_init_cac_custom_achievements_sa"
Hooks:PostHook(AchievmentManager, "init_cac_custom_achievements", hook_id, function()
	local trip_mine_count = 0
	local target_count = 40
	local listener_key = {}

	managers.player:register_message("trip_mine_placed", listener_key, function()
		if not Global.statistics_manager.playing_from_start then
			return
		end

		trip_mine_count = trip_mine_count + 1
		local num_plrs = managers.network:session():amount_of_players()
		target_count = math.min(num_plrs * 14, 40)

		if trip_mine_count == target_count then
			managers.achievment:award("cac_15")
		end
	end)
end)
