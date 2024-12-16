--[[
    Author: Igromanru
    Date: 16.12.2024
    Mod Name: Display Ping
    Version: 1.0.0
]]
local UIWorkspaceSettings = require("scripts/settings/ui/ui_workspace_settings")
local UIFontSettings = require("scripts/managers/ui/ui_font_settings")
local UIWidget = require("scripts/managers/ui/ui_widget")
local UIHudSettings = require("scripts/settings/ui/ui_hud_settings")

local SCENEGRAPH_ID = "display_ping"

local default_settings = {
    position = { 0, 10, 0 },
}

default_settings.get_size_vector2 = function(self)
    return { 200, 30 }
end

local scenegraph_definition = {
    screen = UIWorkspaceSettings.screen,
    [SCENEGRAPH_ID] = {
        parent = "screen",
        vertical_alignment = "top",
        horizontal_alignment = "center",
        size = default_settings:get_size_vector2(),
        position = default_settings.position
    }
}

local widget_definitions = {
    [SCENEGRAPH_ID] = UIWidget.create_definition({
		{
			pass_type = "text",
            style_id = "ping_text",
            value = "0",
			style = {
				vertical_alignment = "center",
                horizontal_alignment = "center",
                text_vertical_alignment = "center",
                text_horizontal_alignment = "center",
                offset = { 0, 0, 0 },
                size = default_settings:get_size_vector2(),
                text_color = Color.white(255, true)
			},
		}
	}, SCENEGRAPH_ID)
}

return {
    scenegraph_definition = scenegraph_definition,
    widget_definitions = widget_definitions,
    scenegraph_id = SCENEGRAPH_ID,
}