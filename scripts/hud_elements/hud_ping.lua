--[[
    Author: Igromanru
    Date: 16.12.2024
    Mod Name: Display Ping
    Version: 1.0.0
]]
local mod = get_mod("DisplayPing")

local UIWidget = require("scripts/managers/ui/ui_widget")
local HudPingDefinitions = mod:io_dofile("DisplayPing/scripts/hud_elements/hud_ping_definitions")
local SettingNames = mod:io_dofile("DisplayPing/scripts/setting_names")

---@class HudPing: HudElementBase
local HudPing = class("HudPing", "HudElementBase")

HudPing.init = function (self, parent, draw_layer, start_scale)
	HudPing.super.init(self, parent, draw_layer, start_scale, HudPingDefinitions)

end

HudPing.destroy = function (self, ui_renderer)
	HudPing.super.destroy(self, ui_renderer)
end

HudPing.update = function (self, dt, t, ui_renderer, render_settings, input_service)
	HudPing.super.update(self, dt, t, ui_renderer, render_settings, input_service)
end

HudPing._draw_widgets = function (self, dt, t, input_service, ui_renderer, render_settings)
	HudPing.super._draw_widgets(self, dt, t, input_service, ui_renderer, render_settings)
	
end

HudPing.set_scenegraph_position = function (self, scenegraph_id, x, y, z, horizontal_alignment, vertical_alignment)
	HudPing.super.set_scenegraph_position(self, scenegraph_id, x, y, z, horizontal_alignment, vertical_alignment)
	-- mod:echo("set_scenegraph_position: scenegraph_id: %s, x: %f, y: %f, z: %f, horizontal: %s, vertical: %s", scenegraph_id, x, y, z, tostring(horizontal_alignment), tostring(vertical_alignment))
end

HudPing.get_scenegraph_id = function()
	return HudPingDefinitions.scenegraph_id
end

return HudPing