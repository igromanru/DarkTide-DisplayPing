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

mod.round = function (num, decimal_places)
    local mult = 10^(decimal_places or 0)
    return math.floor(num * mult + 0.5) / mult
end

mod.get_ping_color_array = function(self)
	local r = self.round(tonumber(self:get(SettingNames.PingColorR)) / 255, 3)
	local g = self.round(tonumber(self:get(SettingNames.PingColorG)) / 255, 3)
	local b = self.round(tonumber(self:get(SettingNames.PingColorB)) / 255, 3)
    
	return {r,g,b}
end

---@param element_name string
---@return HudElementBase?
mod.get_hud_element = function(element_name)
	local ui_manager = Managers.ui
    if element_name and ui_manager then
        local hud = ui_manager:get_hud()
        if hud then
            return hud:element(element_name)
        end
    end
    return nil
end

local function update_style_settings()
	local ping_element = mod.get_hud_element(ping_hud_element.class_name) ---@type HudPing
	if ping_element then
        local ping_widget = ping_element._widgets_by_name.ping_widget
        if ping_widget then
            -- for key, value in pairs(ping_widget) do
            --     mod:echo("key: %s, value: %s", tostring(key), tostring(value))
            -- end
            ping_widget.style.text_color = mod:get_ping_color_array()
        end
		local id = HudPingDefinitions.scenegraph_id
		ping_element:set_scenegraph_position(id, mod:get(SettingNames.PingXOffset), mod:get(SettingNames.PingYOffset), 0, 
                                            mod:get(SettingNames.PingHorizontalAlignment), mod:get(SettingNames.PingVerticalAlignment))
	end
end

-- local function recreate_hud()
--     local ui_manager = Managers.ui
--     if ui_manager then
--         local hud = ui_manager._hud
--         if hud then
--             -- local player_manager = Managers.player
--             -- local player = player_manager:local_player(1)
--             -- local peer_id = player:peer_id()
--             -- local local_player_id = player:local_player_id()
--             -- local elements = hud._element_definitions
--             -- local visibility_groups = hud._visibility_groups

--             -- hud:destroy()
--             -- ui_manager:create_player_hud(peer_id, local_player_id, elements, visibility_groups)

-- 			update_style_settings(ui_manager._hud)
--         end
--     end
-- end

mod.on_all_mods_loaded = function()
    update_style_settings()
end

mod.on_setting_changed = function(setting_id)
    update_style_settings()
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
