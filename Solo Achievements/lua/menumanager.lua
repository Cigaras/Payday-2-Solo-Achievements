_G.SoloAchievements = _G.SoloAchievements or {}
SoloAchievements._path = ModPath
SoloAchievements._data_path = SavePath .. 'solo_achievements.txt'
SoloAchievements.settings = {
	increase_forklift_capacity = false
}

function SoloAchievements:Load()
	local file = io.open(self._data_path, 'r')
	if file then
		for k, v in pairs(json.decode(file:read('*all')) or {}) do
			self.settings[k] = v
		end
		file:close()
	end
end

function SoloAchievements:Save()
	local file = io.open(self._data_path, 'w+')
	if file then
		file:write(json.encode(self.settings))
		file:close()
	end
end

Hooks:Add('LocalizationManagerPostInit', 'LocalizationManagerPostInit_SoloAchievements', function(loc)
	for _, filename in pairs(file.GetFiles(SoloAchievements._path .. 'loc/')) do
		local str = filename:match('^(.*).txt$')
		if str and Idstring(str) and Idstring(str):key() == SystemInfo:language():key() then
			loc:load_localization_file(SoloAchievements._path .. 'loc/' .. filename)
			break
		end
	end

	loc:load_localization_file(SoloAchievements._path .. 'loc/english.txt', false)
end)

Hooks:Add('MenuManagerInitialize', 'MenuManagerInitialize_SoloAchievements', function(menu_manager)

	MenuCallbackHandler.SoloAchievementsIncreaseForkliftCapacity = function(this, item)
		SoloAchievements.settings.increase_forklift_capacity = item:value() == 'on'
	end

	MenuCallbackHandler.SoloAchievementsSave = function(this, item)
		SoloAchievements:Save()
	end

	SoloAchievements:Load()

	MenuHelper:LoadFromJsonFile(SoloAchievements._path .. 'menu/options.txt', SoloAchievements, SoloAchievements.settings)

    -- Long Fellow trophy
    if SoloAchievements.settings.increase_forklift_capacity then
        tweak_data.vehicle.forklift.max_loot_bags = 8
    else
        tweak_data.vehicle.forklift.max_loot_bags = 3
    end

end)
