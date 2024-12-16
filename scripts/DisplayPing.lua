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

mod:add_require_path(ping_hud_element.filename)

mod.ping = 0

---@param elements any[]
---@return HudPing?
local function get_hud_ping_element(elements)
	if not elements or table.is_empty(elements) then return nil end

	return elements[ping_hud_element.class_name]
end

local function update_style_settings(hud)
	if not hud or not hud._elements then return end

	local hud_ping = get_hud_ping_element(hud._elements)
	if hud_ping then
		local id = HudPingDefinitions.scenegraph_id
		hud_ping:set_scenegraph_position(id, mod:get(SettingNames.PingXOffset), mod:get(SettingNames.PingYOffset), 0, 
                                            mod:get(SettingNames.PingHorizontalAlignment), mod:get(SettingNames.PingVerticalAlignment))
	end
end

local function recreate_hud()
    local ui_manager = Managers.ui
    if ui_manager then
        local hud = ui_manager._hud
        if hud then
            local player_manager = Managers.player
            local player = player_manager:local_player(1)
            local peer_id = player:peer_id()
            local local_player_id = player:local_player_id()
            local elements = hud._element_definitions
            local visibility_groups = hud._visibility_groups

            hud:destroy()
            ui_manager:create_player_hud(peer_id, local_player_id, elements, visibility_groups)

			update_style_settings(ui_manager._hud)
        end
    end
end

mod.on_all_mods_loaded = function()
    recreate_hud()
end

mod.on_setting_changed = function(setting_id)
    recreate_hud()
end

mod:hook("UIHud", "init", function(func, self, elements, visibility_groups, params)
	if elements then
		if not table.find_by_key(elements, "class_name", ping_hud_element.class_name) then
			table.insert(elements, {
				class_name = ping_hud_element.class_name,
				filename = ping_hud_element.filename,
				use_hud_scale = true,
				visibility_groups = {
                    "tactical_overlay",
					-- "alive",
				},
			})
		end
	end
    return func(self, elements, visibility_groups, params)
end)

mod:hook_safe(CLASS.PingReporter, "_take_measure", function(self, dt)
    mod.ping = self._measures[#self._measures]
end)
