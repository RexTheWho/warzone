Hooks:PostHook(InteractionTweakData,"init","wz_init",function(self)

	self.munitions_carry_drop = deep_clone(self.carry_drop)
	self.munitions_carry_drop.text_id = "hud_int_hold_grab_munitions"
	self.munitions_carry_drop.action_text_id = "hud_action_grabbing_munitions"
	self.rations_carry_drop = deep_clone(self.carry_drop)
	self.rations_carry_drop.text_id = "hud_int_hold_grab_rations"
	self.rations_carry_drop.action_text_id = "hud_action_grabbing_rations"
	self.scrap_carry_drop = deep_clone(self.carry_drop)
	self.scrap_carry_drop.text_id = "hud_int_hold_grab_scrap"
	self.scrap_carry_drop.action_text_id = "hud_action_grabbing_scrap"
	
end)
