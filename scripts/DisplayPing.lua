--[[
    Author: Igromanru
    Date: 16.12.2024
    Mod Name: Display Ping
    Version: 1.0.0
]]
local mod = get_mod("DisplayPing")
local SettingNames = mod:io_dofile("DisplayPing/scripts/setting_names")
local HudPingDefinitions = mod:io_dofile("DisplayPing/scripts/hud_elements/hud_ping_definitions")

local ping_hud_element = {
    class_name = "HudPing",
    filename = "DisplayPing/scripts/hud_elements/hud_ping",
}

mod.ping = 0
mod.signal_style_update = true

mod.round = function (num, decimal_places)
    if not num then return 0.0 end
    local mult = 10^(decimal_places or 0)
    return math.floor(num * mult + 0.5) / mult
end

mod.get_ping_color_array = function(self, alpha)
    alpha = alpha or 255
	local r = self:get(SettingNames.PingColorR)
	local g = self:get(SettingNames.PingColorG)
	local b = self:get(SettingNames.PingColorB)
    
	return {alpha, r, g, b}
end

mod.get_font_size = function(self)
    return self:get(SettingNames.PingFontSize)
end

mod.get_x_offset = function(self)
    return self:get(SettingNames.PingXOffset)
end

mod.get_y_offset = function(self)
    return self:get(SettingNames.PingYOffset)
end

mod.get_horizontal_alignment = function(self)
    return self:get(SettingNames.PingHorizontalAlignment)
end

mod.get_vertical_alignment = function(self)
    return self:get(SettingNames.PingVerticalAlignment)
end

local function signal_style_update()
    mod.signal_style_update = true
end

mod.on_all_mods_loaded = function()
    signal_style_update()
end

mod.on_setting_changed = function(setting_id)
    signal_style_update()
end

if not mod:register_hud_element({
	class_name = ping_hud_element.class_name,
	filename = ping_hud_element.filename,
	use_hud_scale = true,
	visibility_groups = {
		"tactical_overlay",
		-- "alive",
	},
    validation_function = function (params)
        return mod:get(SettingNames.EnableMod)
    end
}) then
    mod:error("Failed to register Display Ping widget")
end


mod:hook_safe(CLASS.PingReporter, "_take_measure", function(self, dt)
    mod.ping = self._measures[#self._measures]
end)
