Hooks:PostHook(TweakData, "_init_pd2", "wz_tweak_data", function(self)
	self.warzone = {
		env_mapscreen = "levels/mods/warzone/environments/wz_mapscreen"
	}
	self.warzone.map_markers = {
		player = {
			icon = "guis/textures/map_markers",
			texture_rect={0,0,16,16}
		}
	}
	self.warzone.daynight = {
		{
			start_t = 0,
			end_t = 360,
			env_from = "levels/mods/warzone/environments/wz_t0000",
			env_to = "levels/mods/warzone/environments/wz_t0600",
			env_start_t = 180,
			env_end_t = 360
		},
		{
			start_t = 360,
			end_t = 720,
			env_from = "levels/mods/warzone/environments/wz_t0600",
			env_to = "levels/mods/warzone/environments/wz_t1200",
			env_start_t = 360,
			env_end_t = 660
		},
		{
			start_t = 720,
			end_t = 1080,
			env_from = "levels/mods/warzone/environments/wz_t1200",
			env_to = "levels/mods/warzone/environments/wz_t1800",
			env_start_t = 840,
			env_end_t = 1080
		},
		{
			start_t = 1080,
			end_t = 1440,
			env_from = "levels/mods/warzone/environments/wz_t1800",
			env_to = "levels/mods/warzone/environments/wz_t0000",
			env_start_t = 1200,
			env_end_t = 1380,
			last_stage = true
		}
	}
	self.warzone.sun = {
		{
			start_t = -420,
			end_t = 200,
			start_pos = -90,
			end_pos = 100
		},
		{
			start_t = 200,
			end_t = 202,
			start_pos = 100,
			end_pos = 180
		},
		{
			start_t = 202,
			end_t = 204,
			start_pos = -180,
			end_pos = -90
		},
		{
			start_t = 204,
			end_t = 1020,
			start_pos = -90,
			end_pos = 100
		},
		{
			start_t = 1016,
			end_t = 1018,
			start_pos = 100,
			end_pos = 180
		},
		{
			start_t = 1018,
			end_t = 1020,
			start_pos = -180,
			end_pos = -90
		},
		{
			start_t = 1020,
			end_t = 1640,
			start_pos = -90,
			end_pos = 100
		},
	}
end)