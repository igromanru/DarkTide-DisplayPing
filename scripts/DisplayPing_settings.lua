--[[
    Author: Igromanru
    Date: 16.12.2024
    Mod Name: Display Ping
]]
local mod = get_mod("DisplayPing")
local SettingNames = mod:io_dofile("DisplayPing/scripts/setting_names")

mod.is_enabled = function(self)
    return self:get(SettingNames.EnableMod)
end

mod.tactical_overlay_only = function(self)
    return self:get(SettingNames.TacticalOverlayOnly)
end

mod.get_ping_color_array = function(self, alpha)
    alpha = alpha or 255

    local color = mod.Colors.get_color(self:get(SettingNames.PingDefaultColor))
    color = color or Color.white(alpha, true)
    return color
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
