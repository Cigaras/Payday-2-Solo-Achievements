Hooks:PostHook(MissionEndState, "chk_complete_heist_achievements", "MissionEndState_chk_complete_heist_achievements_sa", function (self)
	if self._success then
		-- Reindeer Games, Ghost Riders, Funding Father, Four Monkeys, Sounds of Animals Fighting, Unusual Suspects, Wind of Change, Riders On the Snowstorm, Honor Among Thieves, Animal Kingdom and any future achievement or trophy that will require 4 different masks
		local masks_pass, level_pass, job_pass, jobs_pass, difficulty_pass, difficulties_pass, all_pass, memory, level_id, stage = nil
		local num_plrs = managers.network:session():amount_of_players()

		for achievement, achievement_data in pairs(tweak_data.achievement.four_mask_achievements) do
			level_id = managers.job:has_active_job() and managers.job:current_level_id() or ""
			masks_pass = not not achievement_data.masks
			level_pass = not achievement_data.level_id or achievement_data.level_id == level_id
			job_pass = not achievement_data.job or managers.statistics:started_session_from_beginning() and managers.job:on_last_stage() and managers.job:current_real_job_id() == achievement_data.job
			jobs_pass = not achievement_data.jobs or managers.statistics:started_session_from_beginning() and managers.job:on_last_stage() and table.contains(achievement_data.jobs, managers.job:current_real_job_id())
			difficulty_pass = not achievement_data.difficulty or Global.game_settings.difficulty == achievement_data.difficulty
			difficulties_pass = not achievement_data.difficulties or table.contains(achievement_data.difficulties, Global.game_settings.difficulty)
			all_pass = masks_pass and level_pass and job_pass and jobs_pass and difficulty_pass and difficulties_pass

			if all_pass then
				local available_masks = deep_clone(achievement_data.masks)
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

				all_masks_valid = all_masks_valid and valid_mask_count >= num_plrs

				if all_masks_valid then
					managers.achievment:award_data(achievement_data)
				end
			end
		end
	end

	managers.achievment:clear_heist_success_awards()
end)