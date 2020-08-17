function HUDAccessCamera:wz_enable(enable)
	self._active = enable
    
    self._hud_panel:child("legend_rect_bg"):set_visible(not enable)
    self._hud_panel:child("legend_prev"):set_visible(not enable)
    self._hud_panel:child("legend_next"):set_visible(not enable)
    self._hud_panel:child("legend_exit"):set_visible(not enable)
    self._full_hud_panel:child("destroyed_rect"):set_visible(enable)
    self._full_hud_panel:child("destroyed_rect"):set_alpha(enable and 0 or 1)
    self._hud_panel:child("destroyed_rect_bg"):set_visible(enable)
    self._hud_panel:child("destroyed_text"):set_visible(enable)
    if enable then
        self._hud_panel:child("destroyed_text"):set_text(managers.localization:text("hud_access_camera_connection_lost"))
        self._hud_panel:animate(callback(self, self, "_animate_date"))
    end
end
function HUDAccessCamera:wz_connection_text(text)
    self._hud_panel:child("destroyed_text"):set_text(managers.localization:text(text))
end