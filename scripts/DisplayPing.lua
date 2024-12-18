--[[
    Author: Igromanru
    Date: 16.12.2024
    Mod Name: Display Ping
    Version: 1.1.0
]]
local mod = get_mod("DisplayPing")
mod:io_dofile("DisplayPing/scripts/DisplayPing_settings")

mod.signal_style_update = true

local function round(num, decimal_places)
    local mult = 10^(decimal_places or 0)
    return math.floor(num * mult + 0.5) / mult
end

local last_ping = 0
mod.get_ping = function()
    if not last_ping then return -1 end
    return round(last_ping)
end

mod.get_ping_color = function(self)
    local ping = self.get_ping()

    if ping >= self:get_high_min_value() then
        return self:get_high_color()
    elseif ping >= self:get_middle_min_value() then
        return self:get_middle_color()
    elseif ping >= self:get_low_min_value() then
        return self:get_low_color()
    end

    return self:get_default_color()
end

mod.on_setting_changed = function(setting_id)
    mod.signal_style_update = true
end

mod.is_tactical_overlay_active = function()
    if Managers.ui then
        local hud = Managers.ui:get_hud()
        return hud and hud:tactical_overlay_active()
    end
    return false
end

mod.should_show_ping = function()
    return mod:is_enabled() and (not mod:tactical_overlay_only() or mod:is_tactical_overlay_active())
end

if not mod:register_hud_element({
	class_name = "HudPing",
	filename = "DisplayPing/scripts/hud_elements/hud_ping",
	use_hud_scale = true,
	visibility_groups = {
		"tactical_overlay",
		"alive",
        "dead",
	},
    -- validation_function = function (params)
    --     return mod:is_enabled()
    -- end
}) then
    mod:error("Failed to register Display Ping widget")
end

mod:hook_safe(CLASS.PingReporter, "_take_measure", function(self, dt)
    last_ping = self._measures[#self._measures]
end)
