Hooks:PostHook(HUDManager,"_setup_player_info_hud_pd2","wz_setup_mapscreen",function(self)
    local ws = self:workspace("fullscreen_workspace", "menu")
	self._hud_map_screen = HudMapScreen:new(ws:panel())
end)
function HUDManager:map_respawn_anim(fade_in)
    self._hud_map_screen:play_respawn_fade(fade_in)
end
function HUDManager:set_map_zoom(scale)
    self._hud_map_screen:set_zoom_level(scale)
end
function HUDManager:set_map_status(message, animate)
    self._hud_map_screen:set_status(message, animate)
end
function HUDManager:add_map_marker(i, cam, pos, id)
    self._hud_map_screen:add_marker(i, self._workspace:world_to_screen(cam, pos), id)
end
HudMapScreen = HudMapScreen or class()

function HudMapScreen:init(panel)
    if panel:child("map_panel") then
        panel:remove(panel:child("map_panel"))
    end
    self._markers = {}

    self._hud_panel = panel:panel({name = "map_panel", layer = 100, visible = false})
	local size = self._hud_panel:w() + 50
    
    self._hud_panel:rect({
		valign = "scale",
		name = "destroyed_rect",
		layer = -1,
        color = Color.white,
    })
    
	self._hud_panel:bitmap({
		texture = "core/textures/noise",
		name = "noise",
		valign = "scale",
		wrap_mode = "wrap",
		halign = "scale",
		layer = 3,
		color = Color(0.3, 0, 0, 0),
		w = size,
		h = size
	})
	self._hud_panel:child("noise"):set_texture_rect(0, 0, size, size)
	self._hud_panel:bitmap({
		texture = "core/textures/noise",
		name = "noise2",
		valign = "scale",
		halign = "scale",
		wrap_mode = "wrap",
		y = 0,
		x = 0,
		layer = 3,
		color = Color(0.2, 0, 0, 0),
		w = size,
		h = size
	})
    self._hud_panel:child("noise2"):set_texture_rect(0, 0, size, size)

    local status = self._hud_panel:text({
        name = "status",
        blend_mode = "add",
        layer = 10,
        font = tweak_data.menu.pd2_large_font,
        font_size = tweak_data.menu.pd2_large_font_size/1.2,
        text = "DED",
        visible = false
    })

    local status_bg = self._hud_panel:bitmap({
		name = "status_bg",
		layer = 9,
        color = Color.black,
        w = 10,
        h = 5,
        visible = false
	})
    
    local full_16_9 = managers.gui_data:full_16_9_size()
    local convert_x = full_16_9.convert_x
    local convert_y = full_16_9.convert_y
    
    self._marker_panel = self._hud_panel:panel({
        name = "marker_panel", 
        layer = -2, 
        x = convert_x/2,
        y = convert_y,
        w = self._hud_panel:w() - convert_x,
        h = self._hud_panel:h() - convert_y * 2
    })

    self._details_panel = self._hud_panel:panel({
        name = "details_panel", 
        layer = -8, 
        visible = false
    })

    self._zoom_panel = self._details_panel:panel({
        name = "zoom_panel", 
        layer = 1, 
        x = full_16_9.convert_x/2,
        y = full_16_9.convert_y,
        w = self._hud_panel:w() - full_16_9.convert_x,
        h = self._hud_panel:h() - full_16_9.convert_y * 2
    })
    local cross_indicator_h1 = self._zoom_panel:bitmap({
		texture = "guis/textures/pd2/skilltree/dottedline",
        name = "cross_indicator_h1",
        y = 0,
        h = 2,
        rotation = 360,
		alpha = 0.2,
		wrap_mode = "wrap",
		blend_mode = "add",
		layer = 0,
        w = self._hud_panel:w(),
		color = tweak_data.screen_colors.crimenet_lines
    })
    local cross_indicator_h2 = self._zoom_panel:bitmap({
		texture = "guis/textures/pd2/skilltree/dottedline",
        name = "cross_indicator_h2",
        y = self._zoom_panel:h()+2,
        h = 2,
        rotation = 360,
		alpha = 0.2,
		wrap_mode = "wrap",
		blend_mode = "add",
		layer = 0,
        w = self._hud_panel:w(),
		color = tweak_data.screen_colors.crimenet_lines
    })
    local cross_indicator_v1 = self._zoom_panel:bitmap({
		texture = "guis/textures/pd2/skilltree/dottedline",
        name = "cross_indicator_v1",
        x = 0,
        y = 0,
        h = self._hud_panel:h(),
        rotation = 360,
		alpha = 0.2,
		wrap_mode = "wrap",
		blend_mode = "add",
		layer = 0,
        w = 2,
		color = tweak_data.screen_colors.crimenet_lines
    })
    local cross_indicator_v2 = self._zoom_panel:bitmap({
		texture = "guis/textures/pd2/skilltree/dottedline",
        name = "cross_indicator_v2",
        x = self._zoom_panel:w()+2,
        y = 0,
        h = self._hud_panel:h(),
        rotation = 360,
		alpha = 0.2,
		wrap_mode = "wrap",
		blend_mode = "add",
		layer = 0,
        w = 2,
		color = tweak_data.screen_colors.crimenet_lines
    })
    local line_indicator_h1 = self._zoom_panel:rect({
		blend_mode = "add",
		name = "line_indicator_h1",
		h = 2,
		w = 0,
		alpha = 0.3,
		layer = 1,
		color = tweak_data.screen_colors.crimenet_lines
    })
    local line_indicator_h2 = self._zoom_panel:rect({
		blend_mode = "add",
		name = "line_indicator_h2",
		h = 2,
		w = 0,
		alpha = 0.3,
		layer = 1,
		color = tweak_data.screen_colors.crimenet_lines
    })
    local line_indicator_v1 = self._zoom_panel:rect({
		blend_mode = "add",
		name = "line_indicator_v1",
		h = 0,
		w = 2,
		alpha = 0.3,
		layer = 1,
		color = tweak_data.screen_colors.crimenet_lines
    })
    local line_indicator_v2 = self._zoom_panel:rect({
		blend_mode = "add",
		name = "line_indicator_v2",
		h = 0,
		w = 2,
		alpha = 0.3,
		layer = 1,
		color = tweak_data.screen_colors.crimenet_lines
    })
    local fw = self._details_panel:w()
    local fh = self._details_panel:h()
    
    cross_indicator_h1:set_texture_coordinates(Vector3(0, 0, 0), Vector3(fw, 0, 0), Vector3(0, 2, 0), Vector3(fw, 2, 0))
    cross_indicator_h2:set_texture_coordinates(Vector3(0, 0, 0), Vector3(fw, 0, 0), Vector3(0, 2, 0), Vector3(fw, 2, 0))
    cross_indicator_v1:set_texture_coordinates(Vector3(0, 2, 0), Vector3(0, 0, 0), Vector3(fh, 2, 0), Vector3(fh, 0, 0))
	cross_indicator_v2:set_texture_coordinates(Vector3(0, 2, 0), Vector3(0, 0, 0), Vector3(fh, 2, 0), Vector3(fh, 0, 0))

    self._details_panel:bitmap({
		texture = "guis/textures/test_blur_df",
		name = "blur_top",
		render_template = "VertexColorTexturedBlur3D",
        x = 0,
        y = 0,
		w = self._details_panel:w(),
		h = full_16_9.convert_y,
    })
   self._details_panel:bitmap({
        name = "shade_top",
        layer = 1,
        color = Color.black:with_alpha(0.8),
        x = 0,
        y = 0,
		w = self._details_panel:w() - (full_16_9.convert_x/2),
		h = full_16_9.convert_y,
	})
	self._details_panel:bitmap({
		texture = "guis/textures/test_blur_df",
		name = "blur_right",
		render_template = "VertexColorTexturedBlur3D",
		y = 0,
		w = full_16_9.convert_x,
		h = self._details_panel:h(),
		x = self._details_panel:w() - (full_16_9.convert_x / 2)
    })
    self._details_panel:bitmap({
        name = "shade_right",
        layer = 1,
        color = Color.black:with_alpha(0.8),
		y = 0,
		w = full_16_9.convert_x,
		h = self._details_panel:h() - full_16_9.convert_y,
		x = self._details_panel:w() - (full_16_9.convert_x / 2)
	})
	self._details_panel:bitmap({
		texture = "guis/textures/test_blur_df",
		name = "blur_bottom",
		render_template = "VertexColorTexturedBlur3D",
		x = 0,
		w = self._details_panel:w(),
		h = full_16_9.convert_y,
		y = self._details_panel:h() - full_16_9.convert_y
    })
    self._details_panel:bitmap({
        name = "shade_bottom",
        layer = 1,
        color = Color.black:with_alpha(0.8),
		x = 0,
		w = self._details_panel:w(),
		h = full_16_9.convert_y,
		y = self._details_panel:h() - full_16_9.convert_y
	})
	self._details_panel:bitmap({
		texture = "guis/textures/test_blur_df",
		name = "blur_left",
        render_template = "VertexColorTexturedBlur3D",
        x = 0,
		y = 0,
		w = full_16_9.convert_x/2,
		h = self._details_panel:h()
    })
    self._details_panel:bitmap({
        name = "shade_left",
        layer = 1,
        color = Color.black:with_alpha(0.8),
        x = 0,
		y = full_16_9.convert_y,
		w = full_16_9.convert_x/2,
		h = self._details_panel:h() - (full_16_9.convert_y*2)
	})
    self._details_panel:rect({
        texture = "guis/textures/pd2/skilltree/dottedline",
		h = 2,
		y = full_16_9.convert_y,
		x = full_16_9.convert_x / 2,
		layer = 2,
		w = self._details_panel:w() - full_16_9.convert_x,
        color = tweak_data.screen_colors.crimenet_lines,
        alpha = 0.2
    })
    self._details_panel:rect({
		blend_mode = "add",
		h = 2,
		y = 0,
		x = full_16_9.convert_x / 2,
		layer = 2,
		w = self._details_panel:w() - full_16_9.convert_x,
        color = tweak_data.screen_colors.crimenet_lines,
        alpha = 0.2
    }):set_bottom(self._details_panel:h() - full_16_9.convert_y)
    self._details_panel:rect({
		blend_mode = "add",
		h = self._details_panel:h() - full_16_9.convert_y *2,
		y = full_16_9.convert_y,
		x = full_16_9.convert_x / 2,
		layer = 2,
		w = 2,
        color = tweak_data.screen_colors.crimenet_lines,
        alpha = 0.2
    })
    self._details_panel:rect({
		blend_mode = "add",
		h = self._details_panel:h() - full_16_9.convert_y *2,
		y = full_16_9.convert_y,
		x = 0,
		layer = 2,
		w = 2,
        color = tweak_data.screen_colors.crimenet_lines,
        alpha = 0.2
    }):set_right(self._details_panel:w() - full_16_9.convert_x / 2)

    self._details_panel:text({
        name = "text",
        layer = 5,
        font = tweak_data.menu.pd2_large_font,
        font_size = tweak_data.menu.pd2_large_font_size/2,
		align = "right",
        text = "Time: 00:00 <",
        y = full_16_9.convert_y * 2,
        w = self._details_panel:w() - full_16_9.convert_x
    })
    self._details_panel:text({
        name = "text",
        layer = 5,
        font = tweak_data.menu.pd2_large_font,
        font_size = tweak_data.menu.pd2_large_font_size/2,
		align = "right",
        text = "No Active Objective <",
        y = full_16_9.convert_y * 2+25,
        w = self._details_panel:w() - full_16_9.convert_x
    })
    self._details_panel:rect({
        x = full_16_9.convert_x,
		y = full_16_9.convert_y*2,
		layer = 2,
        w = 15,
        h = 3,
    })

    local zoom_bottom = self._details_panel:rect({
        name = "zoom_bar",
        x = full_16_9.convert_x,
		y = full_16_9.convert_y*2,
		layer = 2,
        w = 3,
        h = self._details_panel:h() - full_16_9.convert_y*4,
    })

    self._details_panel:rect({
        x = full_16_9.convert_x,
		y = full_16_9.convert_y*2,
		layer = 2,
        w = 15,
        h = 3,
    }):set_bottom(zoom_bottom:bottom())
    
    self._zoom_box = HUDBGBox_create(self._details_panel, {
        x = full_16_9.convert_x+8,
        y = full_16_9.convert_y*2+8,
        w = 50,
        h = 30,
        layer = 5
    })
    self._zoom_box:child("bg"):set_alpha(0.5)
    
    self._zoom_box:text({
        name = "text",
        layer = 1,
        font = tweak_data.menu.pd2_large_font,
        font_size = tweak_data.menu.pd2_large_font_size/2,
        vertical = "center",
		align = "center",
        text = "100",
    })

    self._rasteroverlay = self._details_panel:bitmap({
		texture = "guis/textures/crimenet_map_rasteroverlay",
		name = "rasteroverlay",
		layer = 1,
		wrap_mode = "wrap",
		texture_rect = {
			0,
			0,
			32,
			256
		},
		color = Color(0.1, 0, 0, 0),
		w = self._details_panel:w(),
		h = self._details_panel:h()
    })
    local corners = HUDBGBox_create(self._details_panel, {
        x = full_16_9.convert_x / 2,
        y = full_16_9.convert_y,
        w = self._details_panel:w() - full_16_9.convert_x,
        h = self._details_panel:h() - full_16_9.convert_y *2,
        layer = 5
    })
end
function HudMapScreen:add_marker(i, pos, id)
    local tweak = tweak_data.warzone.map_markers[id]
    if tweak then
        if not self._markers[i] then
            self._markers[i] = self._marker_panel:bitmap({
                name = "marker_test",
                h = 15,
                w = 15,
                layer = -2,
                texture = tweak.icon,
                texture_rect = tweak.texture_rect,
                color = Color.white
            })
        end
        self._markers[i]:set_center(pos.x-self._marker_panel:x(), pos.y-self._marker_panel:y())
    end
end
function HudMapScreen:max_markers(amount)
	while amount < #self._markers do
		local obj = table.remove(self._markers, amount + 1)

		self._marker_panel:remove(obj)
	end
end
function HudMapScreen:set_zoom_level(scale)
    scale = math.clamp(scale, 0, 1)
    local full_16_9 = managers.gui_data:full_16_9_size()
    local convert_x = full_16_9.convert_x
    local convert_y = full_16_9.convert_y
    local w = math.lerp(self._hud_panel:w() - convert_x*4, convert_x*6, scale)
    local h = math.lerp(self._hud_panel:h() - convert_y*2, convert_y*6, scale)
    local zoom_bar = self._details_panel:child("zoom_bar")
    self._zoom_panel:set_size(w,h)
    self._zoom_panel:set_center(self._hud_panel:w() / 2, self._hud_panel:h() / 2)
    self._zoom_box:set_y(math.lerp(zoom_bar:bottom()-38, zoom_bar:top() + 8, scale))
    self._zoom_box:child("text"):set_text(math.round(scale*100).."%")

    local cross_indicator_h1 = self._zoom_panel:child("cross_indicator_h1")
    local cross_indicator_h2 = self._zoom_panel:child("cross_indicator_h2")
    local cross_indicator_v1 = self._zoom_panel:child("cross_indicator_v1")
    local cross_indicator_v2 = self._zoom_panel:child("cross_indicator_v2")
    local line_indicator_h1 = self._zoom_panel:child("line_indicator_h1")
    local line_indicator_h2 = self._zoom_panel:child("line_indicator_h2")
    local line_indicator_v1 = self._zoom_panel:child("line_indicator_v1")
    local line_indicator_v2 = self._zoom_panel:child("line_indicator_v2")

    cross_indicator_h1:set_center_x(self._zoom_panel:w() / 2)
    cross_indicator_h2:set_center_x(self._zoom_panel:w() / 2)
    cross_indicator_h2:set_bottom(self._zoom_panel:h())
    cross_indicator_v1:set_center_y(self._zoom_panel:h() / 2)
    cross_indicator_v2:set_center_y(cross_indicator_v1:center_y())
    cross_indicator_v2:set_right(self._zoom_panel:w())

    line_indicator_h1:set_w(self._zoom_panel:w())
    line_indicator_h1:set_center_x(cross_indicator_h1:center_x())
    line_indicator_h2:set_w(self._zoom_panel:w())
    line_indicator_h2:set_center_x(cross_indicator_h1:center_x())
    line_indicator_h2:set_bottom(self._zoom_panel:h())
    line_indicator_v1:set_h(self._zoom_panel:h())
    line_indicator_v1:set_center_y(cross_indicator_v1:center_y())
    line_indicator_v2:set_h(self._zoom_panel:h())
    line_indicator_v2:set_center_y(cross_indicator_v1:center_y())
    line_indicator_v2:set_right(self._zoom_panel:w())
end
function HudMapScreen:set_status(message, animate)
    local status = self._hud_panel:child("status")
    local status_bg = self._hud_panel:child("status_bg")
    local full_16_9 = managers.gui_data:full_16_9_size()

    status:set_text(managers.localization:to_upper_text(message))
    managers.hud:make_fine_text(status)
    status:set_center(self._hud_panel:w() / 2, full_16_9.convert_y * 4)
    status_bg:set_size(status:w()+15, status:h())
    status_bg:set_center(status:center())

    status:set_visible(true)
    status_bg:set_visible(true)
end
function HudMapScreen:play_respawn_fade(fade_in)
    if fade_in then
        self._hud_panel:animate(callback(self, self, "_animate_fade_in"))
    else
        self._hud_panel:animate(callback(self, self, "_animate_fade_out"))
    end
end
function HudMapScreen:_animate_static(noise)
	while self._active do
		local dt = coroutine.yield()
		noise:set_x(-math.random(50))
        noise:set_y(-math.random(50))
        self._rasteroverlay:set_texture_rect(0, -math.mod(Application:time() * 5, 32), 32, 640)
	end
end

function HudMapScreen:_animate_fade_in(panel)
    local background = panel:child("destroyed_rect")
    self._active = true
    self._hud_panel:child("noise"):animate(callback(self, self, "_animate_static"))
    self._hud_panel:set_alpha(0)
    background:set_alpha(0)
    self._hud_panel:set_visible(true)

    over(0.5, function(o)
        panel:set_alpha(o)
    end)

    over(0.05, function(o)
        background:set_alpha(math.random())
        wait(0.1)
    end)
    background:set_alpha(1)
    self._details_panel:set_visible(true)
    self:add_marker(1, {x = self._hud_panel:w()/2, y = self._hud_panel:h()/2}, "player")
    wait(2)
    over(0.2, function(o)
        background:set_alpha(1-o)
    end)
    wait(0.3)
    over(0.05, function(o)
        self._markers[1]:set_visible(not self._markers[1]:visible())
        wait(0.1)
    end)
    managers.hud._sound_source:post_event("menu_error")
    self._markers[1]:set_visible(false)
end

function HudMapScreen:_animate_fade_out(panel)
    local background = panel:child("destroyed_rect")
    self._hud_panel:set_alpha(1)
    background:set_alpha(0)
    self._hud_panel:set_visible(true)
    self._hud_panel:child("status"):set_visible(false)
    self._hud_panel:child("status_bg"):set_visible(false)

    over(0.05, function(o)
        self._markers[1]:set_visible(not self._markers[1]:visible())
        wait(0.1)
    end)
    managers.hud._sound_source:post_event("prompt_enter")
    self._markers[1]:set_visible(true)
    wait(0.4)
    over(0.2, function(o)
        background:set_alpha(o)
    end)
    self._details_panel:set_visible(false)
    self:max_markers(0)
    wait(0.3)
    over(0.05, function(o)
        background:set_alpha(math.random())
        wait(0.1)
    end)
    background:set_alpha(0)
    over(0.5, function(o)
        panel:set_alpha(1-o)
    end)
    self._active = false
    self._hud_panel:set_visible(false)
end
function HudMapScreen:wz_enable(enable)
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

function HudMapScreen:wz_track(found)
    self._markers[1]:animate(callback(self, self, "_animate_track"), found)
end

function HudMapScreen:_animate_track(tracker, found)
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