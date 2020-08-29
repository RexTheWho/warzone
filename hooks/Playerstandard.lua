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

function PlayerStandard:_start_action_mantle(t, input, destination_object)
	self:_interupt_action_running(t)
	self:_interupt_action_ducking(t, true)
    self:_interupt_action_steelsight(t)
    self:_interupt_action_reload(t)

    self._state_data.on_zipline = true
    self._state_data.zipline_data = {
        zipline_unit = nil
    }
    self._state_data.zipline_data.start_pos = self._unit:position()
    self._state_data.zipline_data.end_pos = destination_object:position()
    self._state_data.zipline_data.slack = -math.max(0, math.abs(self._state_data.zipline_data.start_pos.z - self._state_data.zipline_data.end_pos.z) / 2)
    self._state_data.zipline_data.tot_t = (self._state_data.zipline_data.end_pos - self._state_data.zipline_data.start_pos):length() / 300
    self._state_data.zipline_data.t = 0
    self._state_data.zipline_data.camera_shake = nil

    local enemy_vec = mvector3.copy(self._state_data.zipline_data.end_pos)

    mvector3.subtract(enemy_vec, self._unit:movement():m_pos())
    mvector3.set_z(enemy_vec, 0)
    mvector3.normalize(enemy_vec)
    self._ext_camera:camera_unit():base():clbk_aim_assist({
        ray = enemy_vec
    })

    self._ext_camera:play_redirect(self:get_animation("use"))
    self._ext_camera:play_shaker("player_start_running", 3)
    self._unit:sound():play("bar_rescue")
    self._unit:sound():play("bar_rescue_finished")

	self._unit:kill_mover()
end

Hooks:PostHook(PlayerStandard,"_check_action_jump","wz_climb_rope",function(self, t, input)
    local interact_unit = self._interaction:active_unit()
    
    local new_action = nil
    local action_wanted = input.btn_jump_press
    if action_wanted and interact_unit then
        local action_forbidden = not self._is_jumping
        action_forbidden = action_forbidden or (not interact_unit:interaction()._destination_object) or self:_changing_weapon() or self:_is_throwing_projectile() or self:_is_meleeing() or self._unit:base():stats_screen_visible() or not self._state_data.in_air or self:_interacting() or self:_on_zipline() or self:_does_deploying_limit_movement() or self:_is_using_bipod()
        if not action_forbidden then
            self:_start_action_mantle(t, input, interact_unit:interaction()._destination_object)
        end
    end
end)