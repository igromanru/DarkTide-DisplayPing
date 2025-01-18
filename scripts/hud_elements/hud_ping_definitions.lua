--[[
    Author: Igromanru
    Date: 16.12.2024
    Mod Name: Display Ping
]]

local UIWorkspaceSettings = require("scripts/settings/ui/ui_workspace_settings")
local UIWidget = require("scripts/managers/ui/ui_widget")

local SCENEGRAPH_ID = "display_ping"

return {
    scenegraph_definition = {
        screen = UIWorkspaceSettings.screen,
        [SCENEGRAPH_ID] = {
            parent = "screen",
            vertical_alignment = "top",
            horizontal_alignment = "center",
            size = { 40, 40 },
            position = { 0, 10, 0 },
            offset = { 0, 0, 0 },
        }
    },
    widget_definitions = {
        ping_widget = UIWidget.create_definition({
            {
                pass_type = "circle",
                style_id = "ping_symbol",
                value_id = "ping_symbol",
                style = {
                    vertical_alignment = "center",
                    horizontal_alignment = "center",
                    offset = { 0, 0, 2 },
                    size = { 20, 20 },
                    color = Color.white(0, true)
                },
            },
            {
                pass_type = "text",
                style_id = "ping_label",
                value_id = "ping_label",
                value = "",
                style = {
                    font_type = "machine_medium",
                    font_size = 30,
                    drop_shadow = true,
                    text_vertical_alignment = "center",
                    text_horizontal_alignment = "center",
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
                    offset = { 0, 0, 3 },
                    text_color = Color.white(255, true)
                },
            },
        }, SCENEGRAPH_ID)
    },
    scenegraph_id = SCENEGRAPH_ID,
}
