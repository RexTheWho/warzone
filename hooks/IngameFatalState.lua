function IngameFatalState:update(t, dt)
	local player = managers.player:player_unit()

	if not alive(player) then
		return
	end

	if self._anim_time then
		self._anim_time = self._anim_time - dt
		if self._anim_stage == 3 then
			self._cam_unit:camera():modify_fov(dt * 50)
			managers.hud:set_map_zoom(self._anim_time / 0.8)
			if t > self._sound_delay then
				managers.hud._sound_source:post_event("zoom_out")
				self._sound_delay = t + 0.08
			end
		elseif self._anim_stage == 5 then
			local time = self._anim_time/2
			self._cam_unit:set_position(math.lerp(self._end_pos, self._start_pos, time*time*time))
		elseif self._anim_stage == 7 then
			self._cam_unit:camera():modify_fov(-dt * 60)
			managers.hud:set_map_zoom(1-self._anim_time / 0.6)
			if t > self._sound_delay then
				managers.hud._sound_source:post_event("zoom_in")
				self._sound_delay = t + 0.08
			end
		end
		if self._anim_time <= 0 then
			self:next_stage(t, dt)
		end
	end

end

function IngameFatalState:next_stage(t, dt)
	local player = managers.player:player_unit()
	
	if self._anim_stage == 1 then
		self._sound_delay = t + 0.4
		self:enable_camera()
		self._anim_time = 3
	elseif self._anim_stage == 2 then
		self._anim_time = 0.8
	elseif self._anim_stage == 3 then
		--managers.hud._hud_access_camera:wz_track(false)
		self._anim_time = 2
		managers.hud:set_map_status("hud_access_camera_reconnecting")
	elseif self._anim_stage == 4 then
		self._anim_time = 2
		--managers.hud:access_camera_track_max_amount(0)
		--managers.hud:set_access_camera_name(managers.localization:text("hud_access_camera_reconnecting"))
	elseif self._anim_stage == 5 then
		managers.hud:set_map_status("hud_access_camera_reconnected")
		--managers.hud:set_access_camera_name(managers.localization:text("hud_access_camera_reconnected"))
		--managers.hud:access_camera_track(1, self._cam_unit:camera()._camera, self._end_pos)
		--managers.hud._hud_access_camera:wz_track(true)
		managers.hud:map_respawn_anim(false)
		self._anim_time = 1
	elseif self._anim_stage == 6 then
		--[[self._sound_source:post_event("shield_full_indicator")
		local effect = clone(managers.overlay_effect:presets().white_fade_out_in)
		effect.fade_in = 0.5
		effect.sustain = 0.3
		effect.fade_out = 0.5
	
		managers.overlay_effect:play_effect(effect)--]]
		player:movement():warp_to(self._respawn_point.position, self._respawn_point.rotation)
		self._anim_time = 0.6
	elseif self._anim_stage == 7 then
		self:disable_camera()
		player:character_damage():respawn()
		managers.music:track_listen_stop()
	end
	self._anim_stage = self._anim_stage+1
end

function IngameFatalState:enable_camera()
	local player = managers.player:player_unit()
	managers.daynight:set_effect(false)
	managers.environment_controller:set_downed_value(0)
	player:base():set_enabled(false)
	player:base():set_visible(false)
	self._cam_unit = CoreUnit.safe_spawn_unit("units/gui/background_camera_01/access_camera", Vector3(), Rotation())
	self._cam_unit:set_position(self._start_pos)
	self._cam_unit:camera():set_rotation(Rotation(180,-90,0))
	self._cam_unit:camera():start(0)

	managers.viewport:set_override_environment(tweak_data.warzone.env_mapscreen)
	self._cam_unit:camera():modify_fov(-80)

	self._sound_source = self._sound_source or SoundDevice:create_source("IngameFatalState")
	--[[if not managers.hud:exists(IngameAccessCamera.GUI_SAFERECT) then
		managers.hud:load_hud(IngameAccessCamera.GUI_FULLSCREEN, false, true, false, {})
		managers.hud:load_hud(IngameAccessCamera.GUI_SAFERECT, false, true, true, {})
	end
	
    managers.hud:show(IngameAccessCamera.GUI_SAFERECT)
	managers.hud:show(IngameAccessCamera.GUI_FULLSCREEN)
	managers.hud._hud_access_camera:wz_enable(true)--]]

	self._saved_default_color_grading = managers.environment_controller:default_color_grading()
	managers.environment_controller:set_default_color_grading("color_sin", true)
	managers.environment_controller:refresh_render_settings()

	self._sound_source:post_event("camera_monitor_change")
	managers.hud:set_map_zoom(1)
	managers.hud:set_map_status("hud_access_camera_connection_lost")
end

function IngameFatalState:disable_camera()
	local player = managers.player:player_unit()
	managers.daynight:set_effect(true)
	player:base():set_enabled(true)
	player:base():set_visible(true)
	World:delete_unit(self._cam_unit)
	managers.viewport:set_override_environment()

	managers.environment_controller:set_default_color_grading(self._saved_default_color_grading)
	managers.environment_controller:refresh_render_settings()
	managers.hud:hide(IngameAccessCamera.GUI_SAFERECT)
	managers.hud:hide(IngameAccessCamera.GUI_FULLSCREEN)
	--managers.hud._hud_access_camera:wz_enable(false)
end

function IngameFatalState:find_respawn_point()
	local player = managers.player:player_unit()
    local closest = {}
	for _, script in pairs(managers.mission._missions) do
        for _, tbl in pairs(script) do
            if tbl.elements then
                for _, element in pairs(tbl.elements) do
                    if element.class == "ElementPlayerSpawner" and element.values.enabled then
						local dist = mvector3.distance(player:position(), element.values.position)
						if not closest.dist or dist < closest.dist then
							closest.dist = dist
							closest.elem = element
						end
					end
				end
			end
		end
    end
    
    return {position = closest.elem.values.position, rotation = closest.elem.values.rotation}
end
function IngameFatalState:at_enter()
	local player = managers.player:player_unit()
	player:character_damage():stop_heartbeat()
	managers.environment_controller:set_downed_value(100)
	SoundDevice:set_rtpc("downed_state_progression", 100)
	managers.music:track_listen_start("stop_all_music")
	self._sound_source = self._sound_source or SoundDevice:create_source("IngameFatalState")
	
	self._anim_time = 2
	self._anim_stage = 1

	self._start_pos = mvector3.copy(player:position())
	mvector3.set_z(self._start_pos, 45000)
	self._respawn_point = self:find_respawn_point()
	self._end_pos = mvector3.copy(self._respawn_point.position)
	mvector3.set_z(self._end_pos, 45000)
	managers.hud:map_respawn_anim(true)
	--[[local effect = clone(managers.overlay_effect:presets().white_fade_out_in)
	effect.fade_in = 0.8
	effect.sustain = 0.9
	effect.fade_out = 0.2--]]

    managers.overlay_effect:play_effect(effect)
end