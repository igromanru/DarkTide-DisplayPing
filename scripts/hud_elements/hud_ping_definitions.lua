--[[
    Author: Igromanru
    Date: 16.12.2024
    Mod Name: Display Ping
]]
local UIWorkspaceSettings = require("scripts/settings/ui/ui_workspace_settings")
local UIWidget = require("scripts/managers/ui/ui_widget")

local SCENEGRAPH_ID = "display_ping"

local default_settings = {
    position = { 0, 10, 0 },
}

return {
    scenegraph_definition = {
        screen = UIWorkspaceSettings.screen,
        [SCENEGRAPH_ID] = {
            parent = "screen",
            vertical_alignment = "top",
            horizontal_alignment = "center",
            size = { 150, 40 },
            position = default_settings.position
        }
    },
    widget_definitions = {
        ping_widget = UIWidget.create_definition({
            {
                pass_type = "text",
                style_id = "ping_label_left",
                value_id = "ping_label_left",
                value = "",
                style = {
                    font_type = "machine_medium",
                    font_size = 30,
                    drop_shadow = true,
                    text_vertical_alignment = "center",
                    text_horizontal_alignment = "left",
                    offset = { 0, 0, 1 },
                    text_color = Color.white(255, true)
                },
            },
            {
                pass_type = "text",
                style_id = "ping_text",
                value_id = "ping_text",
                value = "",
                style = {
                    font_type = "machine_medium",
                    font_size = 30,
                    drop_shadow = true,
                    text_vertical_alignment = "center",
                    text_horizontal_alignment = "center",
                    offset = { 0, 0, 2 },
                    text_color = Color.white(255, true)
                },
            },
            {
                pass_type = "text",
                style_id = "ping_label_right",
                value_id = "ping_label_right",
                value = "",
                style = {
                    font_type = "machine_medium",
                    font_size = 30,
                    drop_shadow = true,
                    text_vertical_alignment = "center",
                    text_horizontal_alignment = "right",
                    offset = { 0, 0, 1 },
                    text_color = Color.white(255, true)
                },
            },
        }, SCENEGRAPH_ID)
    },
    scenegraph_id = SCENEGRAPH_ID,
}
