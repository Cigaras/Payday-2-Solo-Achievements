Hooks:PreHook(GroupAIStateBase, "check_converted_achievements", "GroupAIStateBase_check_converted_achievements_sa", function (self)
	-- Bring Your Cop To Work Day
	tweak_data.achievement.convert_enemies.double_trouble.count = managers.network:session():amount_of_players()
end)