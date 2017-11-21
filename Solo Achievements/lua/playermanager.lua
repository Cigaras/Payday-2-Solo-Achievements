Hooks:PostHook(PlayerManager, "update", "PlayerManager_update_SoloAchievements", function (self)
	-- Megalo-Mania
    if #self._global.synced_cocaine_stacks >= 1 then
        local amount = 0

        for i, stack in pairs(self._global.synced_cocaine_stacks) do
            if stack.in_use then
                amount = amount + stack.amount
            end

            local num_plrs = managers.network:session():amount_of_players()

            if num_plrs * 390 <= amount then
                managers.achievment:award("mad_5")
            end
        end
    end
end)