--[[
    Author: Igromanru
    Date: 16.12.2024
    Mod Name: Display Ping
]]
local mod = get_mod("DisplayPing")

local HudPingDefinitions = mod:io_dofile("DisplayPing/scripts/hud_elements/hud_ping_definitions")

---@class HudPing: HudElementBase
local HudPing = class("HudPing", "HudElementBase")

HudPing.init = function(self, parent, draw_layer, start_scale)
	HudPing.super.init(self, parent, draw_layer, start_scale, HudPingDefinitions)

	mod.signal_style_update = true
end

HudPing.update = function(self, dt, t, ui_renderer, render_settings, input_service)
	local ping_widget = self._widgets_by_name.ping_widget
	if ping_widget then
		ping_widget.content.ping_text = mod.get_ping()
		self:_update_style(ping_widget)
	end

	HudPing.super.update(self, dt, t, ui_renderer, render_settings, input_service)
end

HudPing._update_style = function(self, ping_widget)
	if mod.signal_style_update then
		mod.signal_style_update = false
		if ping_widget then
			ping_widget.style.ping_text.font_size = mod:get_font_size()
			ping_widget.style.ping_text.text_color = mod:get_ping_color_array()
		end
		self:set_scenegraph_position(HudPingDefinitions.scenegraph_id, mod:get_x_offset(), mod:get_y_offset(), 0,
			mod:get_horizontal_alignment(), mod:get_vertical_alignment())
	end
end

HudPing.draw = function(self, dt, t, ui_renderer, render_settings, input_service)
	if mod:should_show_ping() then
		HudPing.super.draw(self, dt, t, ui_renderer, render_settings, input_service)
	end
end

return HudPing
