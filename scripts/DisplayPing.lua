--[[
    Author: Igromanru
    Date: 16.12.2024
    Mod Name: Display Ping
    Version: 1.6.0
]]
local mod = get_mod("DisplayPing")
mod:io_dofile("DisplayPing/scripts/DisplayPing_settings")

local hud_ping_element = {
    class_name = "HudPing",
    filename = "DisplayPing/scripts/hud_elements/hud_ping"
}

local last_ping = 0
local measures = {}

local function round(num, decimal_places)
    local mult = 10^(decimal_places or 0)
    return math.floor(num * mult + 0.5) / mult
end

mod.round = round

local function add_measure(ping)
    if ping then
        table.insert(measures, ping)
        local remove_count = #measures - mod:get_average_ping_time_frame()
        if remove_count > 0 then
            for i = 1, remove_count do
                table.remove(measures, 1)
            end
        end
    end
end

---@return number
local function get_average_ping()
    if table.is_empty(measures) then return -1 end
    return round(table.average(measures))
end

-- mod.get_hud_element = function()
--     local ui = Managers.ui
--     if ui then
--         local hud = ui:get_hud()
--         return hud and hud:element(hud_ping_element.class_name)
--     end
--     return nil
-- end

---@return number
mod.get_ping = function(self)
    local ping = last_ping

    if self:show_average_ping() then
        ping = get_average_ping()
    end

    if type(ping) ~= "number" then return -1 end
    return round(ping)
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

mod.on_setting_changed = function(setting_id)
    mod.signal_style_update = true
end

mod.is_tactical_overlay_active = function()
    local ui = Managers.ui
    if ui then
        local hud = ui:get_hud()
        return hud and hud:tactical_overlay_active()
    end
    return false
end

mod.should_show_ping = function()
    return mod:is_enabled() and (not mod:tactical_overlay_only() or mod:is_tactical_overlay_active())
end

if not mod:register_hud_element({
	class_name = hud_ping_element.class_name,
	filename = hud_ping_element.filename,
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
    add_measure(last_ping)
end)
