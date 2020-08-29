--CLASSES
dofile(ModPath .. "classes/ClimbingRopeInteractionExt.lua")


Hooks:PostHook(GameSetup,"init_managers","wz_daynight_manager",function(self, managers)
    managers.daynight = DayNightManager:new()
end)

Hooks:PostHook(GameSetup,"update","wz_daynight_update",function(self, t, dt)
    managers.daynight:update(t, dt)
end)

local dummy_material = {
	set_variable = function ()
	end
}
DayNightManager = DayNightManager or class()
function DayNightManager:init()
    self._feeder_map = {}
    self._post_processor_modifier_material_map = {}
    self._apply_prio_feeder_map = {}
    self._apply_feeder_map = {}
    self._env_manager = managers.viewport:_get_environment_manager()
    self._stage = 0
    self._effect_active = true
    self._running = false

end

function DayNightManager:set_enabled(enabled)
   self._running = enabled
end

function DayNightManager:update(t, dt)
    if self._time_tick and self._running then
        self._time_tick = self._time_tick + dt or 0

        local active_vp = managers.viewport:first_active_viewport()
        if self._effect_active and active_vp then
            
            local current_t = self._time_tick - self._stage_data.env_start_t
            local end_t = self._stage_data.env_end_t - self._stage_data.env_start_t
            local scale =  math.clamp(current_t / end_t, 0, 1)
            for data_path_key, feeder in pairs(self._feeder_map) do
                self._env_manager:_set_global_feeder(feeder)
                local is_done, is_not_changed = feeder:update(self, scale)
                if not is_not_changed or feeder.FILTER_CATEGORY == "Sky texture path" then
                    self:_add_apply_feeder(feeder)
                end
            end

            local render_params = active_vp:render_params()
            if next(self._apply_prio_feeder_map) then
                for _, feeder in pairs(self._apply_prio_feeder_map) do
                        feeder:apply(self, active_vp:vp(), render_params[1])
                end
        
                self._apply_prio_feeder_map = {}
            end
        
            if next(self._apply_feeder_map) then
                for _, feeder in pairs(self._apply_feeder_map) do
                        feeder:apply(self, active_vp:vp(), render_params[1])
                end
        
                self._apply_feeder_map = {}
            end
        end

        if self._time_tick > self._stage_data.end_t then
            self:set_stage_data(true)
            self:set_feeders()
        end
        if self._time_tick > self._sun_data.end_t then
            self:set_sun_data(true)
        end
        managers.hud:feed_heist_time(self._time_tick)
        local offset = (self._time_tick-self._sun_data.start_t) / (self._sun_data.end_t-self._sun_data.start_t)
        local sun_offset = math.lerp(self._sun_data.start_pos,self._sun_data.end_pos, offset)
        Global._global_light:set_local_rotation(Rotation(222,sun_offset,0))
    end 
end

function DayNightManager:set_time(tick)
    if tick == nil then
        return
    end
    tick = math.clamp(tick, 0, 1440)
    self._time_tick = tick
    self:set_stage_data()
    self:set_sun_data()
    self:set_feeders()

    if managers.hud and managers.hud._hud_heist_timer then
        managers.hud._hud_heist_timer:reset()
    end
end
function DayNightManager:set_stage_data(increment)
    if increment then
        if self._stage == #tweak_data.warzone.daynight then
            self._time_tick = 0
            self._stage = 1
            self:set_sun_data(true)
            if managers.hud and managers.hud._hud_heist_timer then
                managers.hud._hud_heist_timer:reset()
            end
        else
            self._stage = self._stage + 1
        end
    else
        for index, data in ipairs(tweak_data.warzone.daynight) do
            if self._time_tick >= data.start_t and self._time_tick <= data.end_t then
                self._stage = index
            end
        end
    end
    self._stage_data = tweak_data.warzone.daynight[self._stage]
end
function DayNightManager:set_sun_data(increment)
    if increment then
        if self._sun_stage == #tweak_data.warzone.sun then
            self._sun_stage = 1
        else
            self._sun_stage = self._sun_stage + 1
        end
    else
        for index, data in ipairs(tweak_data.warzone.sun) do
            if self._time_tick >= data.start_t and self._time_tick <= data.end_t then
                self._sun_stage = index
            end
        end
    end
    self._sun_data = tweak_data.warzone.sun[self._sun_stage]
end
function DayNightManager:set_feeders()
    if not self._stage_data then
        return
    end

    local env_data = self._env_manager:_get_data(self._stage_data.env_from)
    for data_path_key, value in pairs(env_data) do
		local feeder = self._feeder_map[data_path_key]

		if not feeder then
			feeder = self._env_manager:_create_feeder(data_path_key, value)
            self._feeder_map[data_path_key] = feeder
        else
            feeder:set(value)
        end
        self:_add_apply_feeder(feeder)
    end

    env_data = self._env_manager:_get_data(self._stage_data.env_to)
    for data_path_key, value in pairs(env_data) do
		local feeder = self._feeder_map[data_path_key]
        feeder:set_target(value)
    end
end

function DayNightManager:set_effect(enabled)
    self._effect_active = enabled
end
function DayNightManager:_add_apply_feeder(feeder)
	if feeder.AFFECTED_LIST then
		self._apply_prio_feeder_map[feeder.APPLY_GROUP_ID] = feeder

		for _, affected_feeder in ipairs(feeder.AFFECTED_LIST) do
			self._apply_feeder_map[affected_feeder.APPLY_GROUP_ID] = self._feeder_map[affected_feeder.DATA_PATH_KEY]
		end
	else
		self._apply_feeder_map[feeder.APPLY_GROUP_ID] = feeder
	end
end

function DayNightManager:get_value(data_path_key)
	local feeder = self._feeder_map[data_path_key]

    if feeder then
        return feeder:get_current()
	else
		return nil
	end
end

function DayNightManager:_get_post_processor_modifier_material(viewport, scene, id, ids_processor_name, ids_effect_name, ids_modifier)
	local scene_map = self._post_processor_modifier_material_map[scene]
	local material = nil

	if not scene_map then
		scene_map = {}
		self._post_processor_modifier_material_map[scene] = scene_map
	else
		material = scene_map[id]
	end

	if not material then
		local post_processor = viewport:get_post_processor_effect(scene, ids_processor_name, ids_effect_name)

		if post_processor then
			local modifier = post_processor:modifier(ids_modifier)

			if modifier then
				material = modifier:material()
			else
				material = dummy_material
			end
		else
			material = dummy_material
		end

		scene_map[id] = material
	end

	return material
end