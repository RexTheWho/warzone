Hooks:PostHook(GamePlayCentralManager,"start_heist_timer","wz_start_time",function(self, t, dt)
    self._heist_timer.running = false

    local name = tweak_data.warzone.daynight[1].env_from
    if DB:has("environment", name) then
        managers.daynight:set_time(720)
        managers.daynight:set_enabled(true)
    end
end)