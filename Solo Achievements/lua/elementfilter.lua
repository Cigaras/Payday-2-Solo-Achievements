local orig_func = ElementFilter:_check_players
function ElementFilter:_check_players(...)
	-- for "Tag, You're it!"/ Car Shop
	if managers.job:current_level_id() == "cage" then
		return true
	else
		orig_func(...)
	end
end