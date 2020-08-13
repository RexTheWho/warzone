
local SELECTION = {
	SECONDARY = 1,
	PRIMARY = 2,
	UNDERBARREL = 3
}

Hooks:PostHook(WeaponTweakData,"init","wz_init",function(self, tweak_data)

	-- Make Gun
	self:_init_data_warzone_npc()
	-- Math Gun
	self:_precalculate_values()
	
end)


function WeaponTweakData:_init_data_warzone_npc()

	-- AK SHORTY
	self.ak_short_npc = { usage = "is_rifle", sounds = {}, use_data = {}, auto = {} }
	self.ak_short_npc.categories = {
		"assault_rifle"
	}
	self.ak_short_npc.sounds.prefix = "akm_npc"
	self.ak_short_npc.use_data.selection_index = SELECTION.PRIMARY
	self.ak_short_npc.DAMAGE = 2
	self.ak_short_npc.muzzleflash = "effects/payday2/particles/weapons/762_auto"
	self.ak_short_npc.shell_ejection = "effects/payday2/particles/weapons/shells/shell_556"
	self.ak_short_npc.CLIP_AMMO_MAX = 30
	self.ak_short_npc.NR_CLIPS_MAX = 4
	self.ak_short_npc.auto.fire_rate = 0.2
	self.ak_short_npc.hold = "rifle"
	self.ak_short_npc.alert_size = 6400
	self.ak_short_npc.suppression = 1
	self.ak_short_npc.FIRE_MODE = "auto"
end

-- NORMAL
Hooks:PostHook(WeaponTweakData,"_set_normal","_set_normal_wz",function(self, tweak_data)

	self.ak47_npc.DAMAGE = 0.2
	self.ak_short_npc.DAMAGE = 0.1
	
end)

-- HARD
Hooks:PostHook(WeaponTweakData,"_set_hard","_set_hard_wz",function(self, tweak_data)

	self.ak47_npc.DAMAGE = 0.4
	self.ak_short_npc.DAMAGE = 0.3
	
end)

-- VERY HARD
Hooks:PostHook(WeaponTweakData,"_set_overkill","_set_overkill_wz",function(self, tweak_data)

	self.ak47_npc.DAMAGE = 1
	self.ak_short_npc.DAMAGE = 0.75
	
end)

-- OVERKILL
Hooks:PostHook(WeaponTweakData,"_set_overkill_145","_set_overkill_145_wz",function(self, tweak_data)

	self.ak47_npc.DAMAGE = 2
	self.ak_short_npc.DAMAGE = 1
	
end)

-- MAYHEM
Hooks:PostHook(WeaponTweakData,"_set_easy_wish","_set_easy_wish_wz",function(self, tweak_data)

	self.ak47_npc.DAMAGE = 2.5
	self.ak_short_npc.DAMAGE = 1.5
	
end)

-- DEATH WISH
Hooks:PostHook(WeaponTweakData,"_set_overkill_290","_set_overkill_290_wz",function(self, tweak_data)

	self.ak47_npc.DAMAGE = 3
	self.ak_short_npc.DAMAGE = 2
	
end)

-- DEATH SENTENCE
Hooks:PostHook(WeaponTweakData,"_set_sm_wish","_set_sm_wish_wz",function(self, tweak_data)

	self.ak47_npc.DAMAGE = 4
	self.ak_short_npc.DAMAGE = 3
	
end)

