Hooks:PostHook(PlayerManager,"update","wz_parachute_cd",function(self, t, dt)
    local timer = self._timers.wz_parachute

	if not timer then
		return
    end
    local time_left = self:get_timer_remaining("wz_parachute") or 0
    managers.hud:set_info_meter(nil, {
        icon = "guis/dlcs/coco/textures/pd2/hud_absorb_stack_icon_01",
        max = 1,
        current = 1 -(time_left/tweak_data.player.parachute.cooldown),
        total = 1
    })
end)

Hooks:PostHook(PlayerManager,"spawned_player","wz_parachute_cd",function(self)
    managers.hud:set_info_meter(nil, {
        icon = "guis/dlcs/coco/textures/pd2/hud_absorb_stack_icon_01",
        max = 1,
        current = 1,
        total = 1
    })
end)
