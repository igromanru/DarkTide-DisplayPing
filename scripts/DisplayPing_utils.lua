--[[
    Author: Igromanru
    Date: 16.12.2024
    Mod Name: Display Ping
]]

local mod = get_mod("DisplayPing")
mod:io_dofile("DisplayPing/scripts/DisplayPing_settings")

mod.round = function(num, decimal_places)
    local mult = 10 ^ (decimal_places or 0)
    return math.floor(num * mult + 0.5) / mult
end

mod.get_ping_color = function(self)
    local ping = self:get_ping()

    if ping >= self:get_high_min_value() then
        return self:get_high_color()
    elseif ping >= self:get_middle_min_value() then
        return self:get_middle_color()
    elseif ping >= self:get_low_min_value() then
        return self:get_low_color()
    end

    return self:get_default_color()
end

mod.get_label_color = function(self)
    if self:should_label_use_ping_color() then
        return self:get_ping_color()
    end
    return self:get_label_default_color()
end

mod.get_symbol_color = function(self)
    if self:should_symbol_use_ping_color() then
        return self:get_ping_color()
    end
    return self:get_symbol_default_color()
end

mod.get_circle_symbol_color = function(self)
    if not self:is_circle_symbol_visible() then
        return Color.white(0, true)
    end

    if self:should_symbol_use_ping_color() then
        return self:get_ping_color()
    end
    return self:get_symbol_default_color()
end

mod.is_tactical_overlay_active = function()
    local ui = Managers.ui
    if ui then
        local hud = ui:get_hud()
        return hud and hud:tactical_overlay_active()
    end
    return false
end

mod.is_in_lobby = function()
    local game_mode = Managers.state.game_mode
    if not game_mode then return false end

    return game_mode:is_social_hub()
end

mod.should_show_ping = function()
    if not mod:is_enabled() then return false end

    return mod:is_tactical_overlay_active() or
    (not mod:tactical_overlay_only() and (not mod:is_in_lobby() or not mod:hide_in_lobby()))
end
