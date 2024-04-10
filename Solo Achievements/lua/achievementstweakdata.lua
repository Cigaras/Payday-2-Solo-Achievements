Hooks:PostHook(AchievementsTweakData, "init", "AchievementsTweakData_init_sa", function(self)
	-- Reputation Beyond Reproach and 120 Proof
	for _, achievement_data in pairs(self.complete_heist_statistics_achievements or {}) do
		if achievement_data.num_players then
			if achievement_data.num_players > 1 then
				achievement_data.num_players = 1
			end
		end
	end

	-- Here Comes the Pain Train, Cooking With Style, Boston Saints, Heisters of the Round Table, Original Heisters, Mercenary trophy and Scrap Metal trophy
	for _, achievement_data in pairs(self.complete_heist_achievements) do
		if achievement_data.num_players then
			if achievement_data.num_players > 1 then
				achievement_data.num_players = 1
			end
		end
	end
end)
