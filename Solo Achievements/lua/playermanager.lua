-- Megalo-Mania
Hooks:PostHook(PlayerManager, "update", "PlayerManager_update_sa", function(self)
	local session = managers.network:session()
	if not session then
		return
	end

	if #self._global.synced_cocaine_stacks < 1 then
		return
	end

	local amount = 0
	for _, stack in pairs(self._global.synced_cocaine_stacks) do
		if stack.in_use then
			amount = amount + stack.amount
		end

		if session:amount_of_players() * 390 <= amount then
			managers.achievment:award("mad_5")
		end
	end
end)
