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

	self._ping_cache = 0
	mod.signal_style_update = true
end

HudPing.update = function(self, dt, t, ui_renderer, render_settings, input_service)
	self:_update_ping()
	self:_update_style()

	HudPing.super.update(self, dt, t, ui_renderer, render_settings, input_service)
end

HudPing._update_ping = function(self)
	local ping = mod:get_ping()
	if ping ~= self._ping_cache then
		self._ping_cache = ping
		local ping_widget = self._widgets_by_name.ping_widget
		ping_widget.content.ping_text = ping --mod:format_ping(ping)
		ping_widget.style.ping_text.text_color = mod:get_ping_color()
	end
end

HudPing._update_style = function(self)
	if mod.signal_style_update then
		mod.signal_style_update = false
		local ping_widget = self._widgets_by_name.ping_widget
		local ping_widget_style = ping_widget.style
		local ping_widget_content = ping_widget.content

		local ping_font_size = mod:get_font_size()
		local label_font_size = mod:get_label_font_size()
		local ping_label = mod:get_localized_ping_label()
		local label_default_color = mod:get_label_default_color()
		local label_offset = mod:get_label_offset_to_ping()
		local label_y_offset = mod:get_label_y_offset()

		ping_widget_style.ping_text.font_size = ping_font_size
		ping_widget_style.ping_text.text_color = mod:get_ping_color()
		if mod:is_label_side_right() then
			-- Right label is chosen
			ping_widget_content.ping_label_left = ""
			ping_widget_content.ping_label_right = ping_label
			ping_widget_style.ping_label_right.font_size = label_font_size
			ping_widget_style.ping_label_right.text_color = label_default_color
			ping_widget_style.ping_label_right.offset[2] = label_y_offset
		else
			-- Left label is chosen
			ping_widget_content.ping_label_right = ""
			ping_widget_content.ping_label_left = ping_label
			ping_widget_style.ping_label_left.font_size = label_font_size
			ping_widget_style.ping_label_left.text_color = label_default_color
			ping_widget_style.ping_label_left.offset[2] = label_y_offset
		end

		self:_auto_resize(ping_font_size, ping_label, label_font_size, label_offset)
		
		if not mod:is_custom_hud_mode() then
			self:set_scenegraph_position(HudPingDefinitions.scenegraph_id, mod:get_x_offset(), mod:get_y_offset(), 0,
				mod:get_horizontal_alignment(), mod:get_vertical_alignment())
		end
	end
end

local font_to_length_scale = 0.5
HudPing._auto_resize = function(self, ping_font_size, ping_label, label_font_size, label_offset)
	local scenegraph_width = ping_font_size * font_to_length_scale * 3
	local label_width = label_font_size * font_to_length_scale * string.len(ping_label)
	if label_width > 0 then
		scenegraph_width = scenegraph_width + (label_width + label_offset) * 2
	end
	scenegraph_width = math.max(scenegraph_width, 40)
	self:_set_scenegraph_size(HudPingDefinitions.scenegraph_id, scenegraph_width)
end

HudPing.draw = function(self, dt, t, ui_renderer, render_settings, input_service)
	if mod:should_show_ping() then
		HudPing.super.draw(self, dt, t, ui_renderer, render_settings, input_service)
	end
end

return HudPing
