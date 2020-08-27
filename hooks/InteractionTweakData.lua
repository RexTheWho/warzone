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
	
	self.climbing_rope = {
		text_id = "hud_int_hold_climbing_rope",
		interact_distance = 200,
		timer = 0.1,
		axis = "y",
		start_active = true,
		sound_start = "bar_rescue",
		sound_interupt = "bar_rescue_cancel",
		sound_done = "bar_rescue_finished"
	}
	
end)
