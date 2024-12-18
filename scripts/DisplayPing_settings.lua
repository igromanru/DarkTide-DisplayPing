--[[
    Author: Igromanru
    Date: 16.12.2024
    Mod Name: Display Ping
]]
local mod = get_mod("DisplayPing")
local SettingNames = mod:io_dofile("DisplayPing/scripts/setting_names")

---@return boolean
mod.is_enabled = function(self)
    return self:get(SettingNames.EnableMod)
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
mod.get_font_size = function(self)
    return self:get(SettingNames.PingFontSize)
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
