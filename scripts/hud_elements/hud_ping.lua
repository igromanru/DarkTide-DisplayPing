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
	end
end

HudPing._update_style = function(self, ui_renderer)
	if mod.signal_style_update then
		mod.signal_style_update = false
		local ping_widget = self._widgets_by_name.ping_widget
		local ping_widget_style = ping_widget.style
		local ping_widget_content = ping_widget.content

		-- Ping
		ping_widget_style.ping_text.font_size = mod:get_font_size()
		ping_widget_style.ping_text.text_color = mod:get_ping_color()
		-- Label
		ping_widget_content.ping_label =  mod:get_localized_ping_label()
		ping_widget_style.ping_label.font_size = mod:get_label_font_size()
		ping_widget_style.ping_label.text_color = mod:get_label_color()
		ping_widget_style.ping_label.offset[2] = mod:get_label_y_offset()
		if mod:is_label_side_right() then
			ping_widget_style.ping_label.text_horizontal_alignment = SettingNames.Sides.Right
		else
			ping_widget_style.ping_label.text_horizontal_alignment = SettingNames.Sides.Left
		end
		
		self:_auto_resize(ui_renderer, ping_widget, mod:get_label_offset_to_ping())
		
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
	
	local width, height, min, caret = UIRenderer.text_size(ui_renderer, text, text_style.font_type, text_style.font_size, text_style.size)
	return mod.round(width), mod.round(height), min, caret
end

HudPing._auto_resize = function(self, ui_renderer, widget, label_offset)
	-- "1888" is a workaround to create enough space around
	local scenegraph_width = calculate_text_size(ui_renderer, widget, "ping_text", "1888")
	local label_width = calculate_text_size(ui_renderer, widget, "ping_label")
	if label_width > 0 then
		scenegraph_width = scenegraph_width + (label_width + label_offset) * 2
	end
	-- mod:echo("scenegraph_width: %f", scenegraph_width)
	scenegraph_width = math.max(scenegraph_width, 40)
	self:_set_scenegraph_size(HudPingDefinitions.scenegraph_id, scenegraph_width)
end

HudPing.draw = function(self, dt, t, ui_renderer, render_settings, input_service)
	if mod:should_show_ping() then
		HudPing.super.draw(self, dt, t, ui_renderer, render_settings, input_service)
	end
end

return HudPing
