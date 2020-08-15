Hooks:PostHook(TweakData, "_init_pd2", "wz_tweak_data", function(self)
	self.warzone = {}
	self.warzone.daynight = {
		{
			reset_timer = true,
			change_tick = 360,
			sun_offset = 360,
			enviroment = "levels/mods/warzone/environments/wz_t0600"
		},
		{
			change_tick = 720,
			sun_offset = -360,
			enviroment = "levels/mods/warzone/environments/wz_t1200"
		},
		{
			change_tick = 1080,
			sun_offset = -360,
			enviroment = "levels/mods/warzone/environments/wz_t1800",
			env_change_time = 300
		},
		{
			change_tick = 1320,
			sun_offset = -1080,
			enviroment = "levels/mods/warzone/environments/wz_t0000",
		},
		{
			change_tick = 1440,
			sun_offset = -1080,
			time_offset = -1320
		}
	}
end)