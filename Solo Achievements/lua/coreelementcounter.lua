core:module("CoreElementCounter")

Hooks:PostHook(ElementCounter, "_check_triggers", "ElementCounter__check_triggers_sa", function(self, type)
	if not self._triggers[type] then
		return
	end

	if managers.job:current_level_id() == "alex_3" and self._editor_name == "7bagsSecured" then
		--Short Fuse
		local num_players = managers.network:session():amount_of_players()
		local num_bags = math.min(7, 3*num_players)
		if type ~= "value" or self._values.counter_target == num_bags then
			self._triggers[type][100827].callback()
		end
	end
end)