--[[
    Author: Igromanru
    Date: 16.12.2024
    Mod Name: Display Ping
    Version: 1.6.2
]]
local mod = get_mod("DisplayPing")
mod:io_dofile("DisplayPing/scripts/DisplayPing_settings")
mod:io_dofile("DisplayPing/scripts/DisplayPing_utils")

-- local MatchmakingConstants = require("scripts/settings/network/matchmaking_constants")

local hud_ping_element = {
    class_name = "HudPing",
    filename = "DisplayPing/scripts/hud_elements/hud_ping"
}

local last_ping = 0
local measures = {}

local function add_measure(ping)
    if type(ping) == "number" then
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
    return mod.round(table.average(measures))
end

---@return number
mod.get_ping = function(self)
    local ping = last_ping

    if self:show_average_ping() then
        ping = get_average_ping()
    end

    if type(ping) ~= "number" then return -1 end
    return mod.round(ping)
end

mod.on_setting_changed = function(setting_id)
    mod.signal_style_update = true
end

mod.on_all_mods_loaded = function()
    if not mod:register_hud_element({
            class_name = hud_ping_element.class_name,
            filename = hud_ping_element.filename,
            use_hud_scale = true,
            visibility_groups = {
                "tactical_overlay",
                "alive",
                "dead",
            },
        }) then
        mod:error("Failed to register Display Ping HUD element")
    end

    mod:hook_safe("PingReporter", "_take_measure", function(self, dt)
        last_ping = self._measures[#self._measures]
        add_measure(last_ping)
    end)
end
