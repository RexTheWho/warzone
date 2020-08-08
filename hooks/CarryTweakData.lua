Hooks:PostHook(CarryTweakData,"init","wz_init",function(self)

	self.wz_supply_ration = {
		type =				"medium",
		name_id =			"hud_carry_wz_supply_ration",
		unit =				"units/pd2_mod_wz/supplies/wz_supply_ration/wz_supply_ration",
		visual_unit_name =	"units/pd2_mod_wz/supplies/wz_supply_ration/wz_supply_ration_acc",
		skip_exit_secure = true
	}
	self.wz_supply_scrap = {
		type =				"medium",
		name_id =			"hud_carry_wz_supply_scrap",
		unit =				"units/pd2_mod_wz/supplies/wz_supply_scrap/wz_supply_scrap",
		visual_unit_name =	"units/pd2_mod_wz/supplies/wz_supply_scrap/wz_supply_scrap_acc",
		skip_exit_secure = true
	}
	self.wz_supply_munition = {
		type =				"medium",
		name_id =			"hud_carry_wz_supply_munition",
		unit =				"units/pd2_mod_wz/supplies/wz_supply_munition/wz_supply_munition",
		visual_unit_name =	"units/pd2_mod_wz/supplies/wz_supply_munition/wz_supply_munition_acc",
		skip_exit_secure = true
	}
	
end)
