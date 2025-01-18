--[[
    Author: Igromanru
    Date: 16.12.2024
    Mod Name: Display Ping
]]
local mod = get_mod("DisplayPing")
local SettingNames = mod:io_dofile("DisplayPing/scripts/setting_names")

local UIRenderer = require("scripts/managers/ui/ui_renderer")
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
	self:_update_style(ui_renderer)

	HudPing.super.update(self, dt, t, ui_renderer, render_settings, input_service)
end

HudPing._update_ping = function(self)
	local ping = mod:get_ping()
	if ping ~= self._ping_cache then
		self._ping_cache = ping
		local ping_widget = self._widgets_by_name.ping_widget
		ping_widget.content.ping_text = ping
		ping_widget.style.ping_text.text_color = mod:get_ping_color()
		ping_widget.style.ping_label.text_color = mod:get_label_color()
		ping_widget.style.ping_symbol.color = mod:get_circle_symbol_color()
	end
end

HudPing._update_style = function(self, ui_renderer)
	if mod.signal_style_update then
		mod.signal_style_update = false
		local ping_widget = self._widgets_by_name.ping_widget
		local ping_widget_style = ping_widget.style

		-- Ping
		ping_widget_style.ping_text.font_size = mod:get_font_size()
		ping_widget_style.ping_text.text_color = mod:get_ping_color()
		-- Label
		ping_widget.content.ping_label = mod:get_localized_ping_label()
		ping_widget_style.ping_label.font_size = mod:get_label_font_size()
		ping_widget_style.ping_label.text_color = mod:get_label_color()
		-- Symbol
		ping_widget_style.ping_symbol.size = mod:get_symbol_size_array()
		ping_widget_style.ping_symbol.color = mod:get_circle_symbol_color()

		self:_auto_resize_and_position(ui_renderer, ping_widget)

		if not mod:is_custom_hud_mode() then
			self:set_scenegraph_position(HudPingDefinitions.scenegraph_id, mod:get_x_offset(), mod:get_y_offset(), 0,
				mod:get_horizontal_alignment(), mod:get_vertical_alignment())
		end
		ping_widget.dirty = true
	end
end

---@param ui_renderer UIRenderer
---@param widget table
---@param element_id string
---@param text string?
---@return number width, number height, number min, number caret
local function calculate_text_size(ui_renderer, widget, element_id, text)
	text = text or widget.content[element_id]
	local text_style = widget.style[element_id]

	local width, height, min, caret = UIRenderer.text_size(ui_renderer, text, text_style.font_type, text_style.font_size,
		text_style.size)
	return mod.round(width), mod.round(height), min, caret
end

HudPing._auto_resize_and_position = function(self, ui_renderer, widget)
	local widget_style = widget.style

	-- "1888" is a workaround to create enough space around the ping
	local ping_width = calculate_text_size(ui_renderer, widget, "ping_text", "1888")
	local ping_half_width = (ping_width * 0.5)
	local label_width = 0
	local label_half_width = 0
	local label_offset = 0
	if mod:is_label_visible() then
		label_width = calculate_text_size(ui_renderer, widget, "ping_label")
		label_half_width = (label_width * 0.5)
		label_offset = label_half_width + ping_half_width + mod:get_label_offset_to_ping()
		local ping_label_offsets = widget_style.ping_label.offset
		ping_label_offsets[2] = mod:get_label_y_offset()
		if mod:is_label_side_right() then
			ping_label_offsets[1] = label_offset
		else
			ping_label_offsets[1] = -label_offset
		end
	end
	if mod:is_symbol_visible() then
		local symbol_size = mod:get_symbol_size()
		local symbol_half_size = symbol_size * 0.5
		local is_symbol_side_right = mod:is_symbol_side_right()
		local symbol_offset = symbol_half_size + mod:get_symbol_offset_to_ping()
		if label_offset > 0 and is_symbol_side_right == mod:is_label_side_right() then
			symbol_offset = symbol_offset + label_offset + label_half_width + 6
		else
			symbol_offset = symbol_offset + ping_half_width
		end
		local symbol_label_offsets = widget_style.ping_symbol.offset
		symbol_label_offsets[2] = mod:get_symbol_y_offset()
		if is_symbol_side_right then
			symbol_label_offsets[1] = symbol_offset
		else
			symbol_label_offsets[1] = -symbol_offset
		end
	end

	scenegraph_width = math.max(ping_width + label_width, 40)
	self:_set_scenegraph_size(HudPingDefinitions.scenegraph_id, scenegraph_width)
end

HudPing.draw = function(self, dt, t, ui_renderer, render_settings, input_service)
	if mod:should_show_ping() then
		HudPing.super.draw(self, dt, t, ui_renderer, render_settings, input_service)
	end
end

return HudPing
