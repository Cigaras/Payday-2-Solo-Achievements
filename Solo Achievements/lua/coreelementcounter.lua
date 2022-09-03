core:module("CoreElementCounter")

Hooks:PreHook(ElementCounter, "_check_triggers", "ElementCounter__check_triggers_sa", function (self, type)
	if not self._triggers[type] then
		return
	end

	if managers.job:current_level_id() == "alex_3" and tostring(self:id()) == "100423" then -- 7bagsSecured
		--Short Fuse
		local num_players = managers.network:session():amount_of_players()
		local num_bags = math.min(7, 3*num_players)

		self._triggers[type][100827].amount = num_bags
	end
end)