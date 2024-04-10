-- Reindeer Games, Ghost Riders, Funding Father, Four Monkeys, Sounds of Animals Fighting
-- Unusual Suspects, Wind of Change, Riders On the Snowstorm, Honor Among Thieves
-- Animal Kingdom and any future achievement or trophy that will require 4 different masks

local hook_id = "MissionEndState_chk_complete_heist_achievements_sa"
Hooks:PostHook(MissionEndState, "chk_complete_heist_achievements", hook_id, function(self)
	if not self._success then
		return
	end

	local level_id = managers.job:has_active_job() and managers.job:current_level_id() or ""
	local started_from_beginning = managers.statistics:started_session_from_beginning()
	local is_last_stage = managers.job:on_last_stage()
	local real_job_id = managers.job:current_real_job_id()
	local current_difficulty = Global.game_settings.difficulty

	local masks_pass, level_pass, job_pass, jobs_pass, difficulty_pass, difficulties_pass, all_pass
	for _, data in pairs(tweak_data.achievement.four_mask_achievements) do
		masks_pass = not not data.masks
		level_pass = not data.level_id or data.level_id == level_id
		job_pass = not data.job or started_from_beginning and is_last_stage and real_job_id == data.job
		jobs_pass = not data.jobs or started_from_beginning and is_last_stage and table.contains(data.jobs, real_job_id)
		difficulty_pass = not data.difficulty or current_difficulty == data.difficulty
		difficulties_pass = not data.difficulties or table.contains(data.difficulties, current_difficulty)
		all_pass = masks_pass and level_pass and job_pass and jobs_pass and difficulty_pass and difficulties_pass

		if all_pass then
			local available_masks = deep_clone(data.masks)
			local all_masks_valid = true
			local valid_mask_count = 0

			for _, peer in pairs(managers.network:session():all_peers()) do
				local current_mask = peer:mask_id()
				if table.contains(available_masks, current_mask) then
					table.delete(available_masks, current_mask)

					valid_mask_count = valid_mask_count + 1
				else
					all_masks_valid = false
				end
			end

			if all_masks_valid and valid_mask_count >= managers.network:session():amount_of_players() then
				managers.achievment:award_data(data)
			end
		end
	end

	managers.achievment:clear_heist_success_awards()
end)
