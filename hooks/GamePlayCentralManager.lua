Hooks:PostHook(GamePlayCentralManager,"start_heist_timer","wz_start_time",function(self, t, dt)
    self._heist_timer.running = false
    self._time_tick = 720
    self._time_of_day = 2
    self._time_data = tweak_data.warzone.daynight[self._time_of_day]
    managers.viewport:set_default_environment("levels/mods/warzone/environments/wz_t1200")
end)

Hooks:PostHook(GamePlayCentralManager,"update","wz_time",function(self, t, dt)
    if self._time_tick then
        self._time_tick = self._time_tick + dt or 0

        if self._time_tick >=  self._time_data.change_tick then
            self._time_of_day = self._time_of_day == #tweak_data.warzone.daynight and 1 or self._time_of_day + 1
            self._time_data = tweak_data.warzone.daynight[self._time_of_day]
            if  self._time_data.enviroment then
                managers.viewport:set_default_environment( self._time_data.enviroment,  self._time_data.env_change_time or 240, nil)
            end
            if  self._time_data.reset_timer then
                self._time_tick = 0
            end
            managers.hud._hud_heist_timer:reset()
        end
        local time_offset = self._time_tick + ( self._time_data.sun_offset or -360)

        managers.hud:feed_heist_time(self._time_tick + ( self._time_data.time_offset or 120))
        local sun_offset = math.lerp(130,-70, time_offset/720)
        Global._global_light:set_local_rotation(Rotation(0,0,sun_offset))
    end
end)