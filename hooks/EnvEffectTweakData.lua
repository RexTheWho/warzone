
Hooks:PostHook(EnvEffectTweakData,"init","wz_init",function(self)

	self.warzone_desert = {
		effect_name = Idstring("units/pd2_mod_wz/effects/environment/windy_desert")
	}
	
end)

Hooks:PostHook(EnvironmentEffectsManager,"init","wz_init",function(self)

	self:add_effect("warzone_desert", RainEffect:new(tweak_data.env_effect.warzone_desert))
	
end)
