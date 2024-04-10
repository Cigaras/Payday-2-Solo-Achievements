-- Bring Your Cop To Work Day
local hook_id = "GroupAIStateBase_check_converted_achievements_sa"
Hooks:PreHook(GroupAIStateBase, "check_converted_achievements", hook_id, function()
	tweak_data.achievement.convert_enemies.double_trouble.count = managers.network:session():amount_of_players()
end)
