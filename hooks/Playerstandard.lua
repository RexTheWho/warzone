Hooks:PostHook(PlayerStandard,"_check_action_jump","_check_action_parachute",function(self, t, input)
    local new_action = nil
	local action_wanted = input.btn_jump_press
    
    local can_parachute = self._can_parachute
	if can_parachute and self._state_data.in_air then
        if action_wanted then
            managers.hud:remove_interact()
            managers.player:set_player_state("jerry2")
            managers.player:start_timer("wz_parachute", tweak_data.player.parachute.cooldown)
        end
    end
end)

Hooks:PreHook(PlayerStandard,"_update_foley","_update_airtime",function(self, t, input)
    if not self._gnd_ray and not self._state_data.on_ladder then
		if not self._state_data.in_air then
			self._air_t = t
        end
        if self._air_t and t > self._air_t + tweak_data.player.parachute.trigger_delay and not self._can_parachute and not managers.player:get_timer("wz_parachute") then
            self._can_parachute = true
            local text = managers.localization:text("int_open_parachute", {BTN_INTERACT=managers.localization:btn_macro("jump", false)})
            managers.hud:show_interact({text = text})
        end
    elseif self._gnd_ray and self._can_parachute then
        managers.hud:remove_interact()
        self._can_parachute = false
    end
end)