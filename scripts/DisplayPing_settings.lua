--[[
    Author: Igromanru
    Date: 16.12.2024
    Mod Name: Display Ping
]]
local mod = get_mod("DisplayPing")
local SettingNames = mod:io_dofile("DisplayPing/scripts/setting_names")

local custom_hud_mod = nil

mod.on_all_mods_loaded = function ()
    custom_hud_mod = get_mod("custom_hud")
end

---@return boolean
mod.is_enabled = function(self)
    return true --self:get(SettingNames.EnableMod)
end

---@return boolean
mod.tactical_overlay_only = function(self)
    return self:get(SettingNames.TacticalOverlayOnly)
end

---@return boolean
mod.show_average_ping = function(self)
    return self:get(SettingNames.ShowAveragePing)
end

---@return integer
mod.get_average_ping_time_frame = function(self)
    local value = self:get(SettingNames.ShowAveragePingTimeFrame)
    return value or 20
end

---@return boolean
mod.is_custom_hud_mode = function(self)
    return self:get(SettingNames.CustomHudMode) and custom_hud_mod ~= nil
end

---@return integer
mod.get_font_size = function(self)
    return self:get(SettingNames.PingFontSize)
end

---@return string
mod.get_ping_label = function(self)
    return self:get(SettingNames.PingLabel)
end

---@return string
mod.get_localized_ping_label = function(self)
    local label = self:get_ping_label()
    if not label or label == SettingNames.PingLabels.None then
        return ""
    end
    return self:localize(label)
end

---@return string
mod.format_ping = function(self, ping)
    local ping_label = self:get_ping_label()

    if ping_label == SettingNames.PingLabels.None then
        return ping
    elseif ping_label == SettingNames.PingLabels.MS then
        return string.format("%d %s", ping, self:localize(ping_label))
    end

    return string.format("%s: %d", self:localize(ping_label), ping)
end

---@return integer
mod.get_label_font_size = function(self)
    return self:get(SettingNames.LabelFontSize)
end

---@return integer[]
mod.get_label_default_color = function(self)
    local color = mod.Colors.get_color(self:get(SettingNames.LabelDefaultColor))
    return color or Color.white(255, true)
end

---@return string # Returns "left" or "right"
mod.get_label_side_position = function(self)
    return self:get(SettingNames.LabelSidePosition)
end

---@return boolean
mod.is_label_side_right = function(self)
    return self:get_label_side_position() == "right"
end

---@return integer[]
mod.get_default_color = function(self)
    local color = mod.Colors.get_color(self:get(SettingNames.PingDefaultColor))
    return color or Color.white(255, true)
end

---@return integer[]
mod.get_low_color = function(self)
    local color = mod.Colors.get_color(self:get(SettingNames.PingLowColor))
    return color or Color.online_green(255, true)
end

---@return integer[]
mod.get_middle_color = function(self)
    local color = mod.Colors.get_color(self:get(SettingNames.PingMiddleColor))
    return color or Color.yellow(255, true)
end

---@return integer[]
mod.get_high_color = function(self)
    local color = mod.Colors.get_color(self:get(SettingNames.PingHighColor))
    return color or Color.dark_red(255, true)
end

---@return integer
mod.get_low_min_value = function(self)
    local value = self:get(SettingNames.PingLowMinValue)
    return value or 10
end

---@return integer
mod.get_middle_min_value = function(self)
    local value = self:get(SettingNames.PingMiddleMinValue)
    return value or 60
end

---@return integer
mod.get_high_min_value = function(self)
    local value = self:get(SettingNames.PingHighMinValue)
    return value or 100
end

---@return integer
mod.get_x_offset = function(self)
    return self:get(SettingNames.PingXOffset)
end

---@return integer
mod.get_y_offset = function(self)
    return self:get(SettingNames.PingYOffset)
end

---@return string
mod.get_horizontal_alignment = function(self)
    return self:get(SettingNames.PingHorizontalAlignment)
end

---@return string
mod.get_vertical_alignment = function(self)
    return self:get(SettingNames.PingVerticalAlignment)
end
