function HUDAccessCamera:wz_enable(enable)
	self._active = enable
    
    self._hud_panel:child("legend_rect_bg"):set_visible(not enable)
    self._hud_panel:child("legend_prev"):set_visible(not enable)
    self._hud_panel:child("legend_next"):set_visible(not enable)
    self._hud_panel:child("legend_exit"):set_visible(not enable)

    if enable then
        self:set_camera_name(managers.localization:text("hud_access_camera_connection_lost"))
        self._hud_panel:animate(callback(self, self, "_animate_date"))
    end
end

function HUDAccessCamera:wz_track(found)
    self._markers[1]:animate(callback(self, self, "_animate_track"), found)
end

function HUDAccessCamera:_animate_track(tracker, found)
    if not found then
        over(0.5, function(o) end)
    end
    local visible = not found
    local blinks = 0
    local max_blinks = found and 5 or 7
    while blinks < max_blinks do
        local dt = coroutine.yield()
        
        if blinks > 4 and not found then
            tracker:set_color(Color.red)
        end
        visible = not visible
        tracker:set_visible(visible)
        blinks = blinks + 1
        
        wait(0.08)
    end
    managers.hud._sound_source:post_event(found and "prompt_enter" or "menu_error")
    tracker:set_visible(found)
end