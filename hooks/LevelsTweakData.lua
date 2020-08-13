--[[ TO DO LATER
LevelsTweakData.LevelType.WZCartel = "wzcartel"

Hooks:PostHook(LevelsTweakData,"init","wz_init",function(self)

	local wzcartel = LevelsTweakData.LevelType.WZCartel
	table.insert(self.ai_groups, wzcartel = wzcartel)
	
end)
]]--