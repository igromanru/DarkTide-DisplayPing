--[[
    Author: Igromanru
    Date: 16.12.2024
    Mod Name: Display Ping
]]

---@class SettingNames
local SettingNames = {
    EnableMod = "enable_mod",
    TacticalOverlayOnly = "tactical_overlay_only",
    HideInLobby = "hide_in_lobby",
    HideInLobbyTooltip = "hide_in_lobby_tooltip",
    ShowAveragePing = "show_average_ping",
    ShowAveragePingTooltip = "show_average_ping_tooltip",
    ShowAveragePingTimeFrame = "average_ping_timeframe",
    PositionOnScreen = "position_on_screen",
    CustomHudMode = "custom_hud_mode",
    CustomHudModeTooltip = "custom_hud_mode_tooltip",
    PingHorizontalAlignment = "ping_horizontal_alignment",
    PingVerticalAlignment = "ping_vertical_alignment",
    PingXOffset = "ping_offset_x",
    PingYOffset = "ping_offset_y",
    PingStyleGroup = "ping_style_group",
    PingFontSize = "ping_font_size",
    PingDefaultColor = "ping_default_color",
    PingLabel = "ping_label",
    PingRangeIndicatorGroup = "ping_range_indicator_group",
    PingRangeIndicator = "ping_range_indicator",
    PingLowColor = "ping_low_color",
    PingMiddleColor = "ping_middle_color",
    PingHighColor = "ping_high_color",
    PingLowMinValue = "ping_low_min_value",
    PingMiddleMinValue = "ping_middle_min_value",
    PingHighMinValue = "ping_high_min_value",
    PingLabels = {
        None = "none",
        Ping = "ping",
        Latency = "latency",
        MS = "ms",
    },
    LabelStyleGroup = "label_style_group",
    LabelFontSize = "label_font_size",
    LabelDefaultColor = "label_default_color",
    LabelSidePosition = "label_side_position",
    LabelOffsetToPing = "label_offset_to_ping",
    LabelYOffset = "label_y_offset",
    LabelUsePingColor = "label_use_ping_color",
    Sides = {
        Left = "left",
        Right = "right",
    },
    SymbolGroup = "symbol_style_group",
    Symbol = "symbol",
    SymbolSize = "symbol_size",
    SymbolSidePosition = "symbol_side_position",
    SymbolColor = "symbol_color",
    SymbolOffsetToPing = "symbol_offset_to_ping",
    SymbolYOffset = "symbol_y_offset",
    SymbolUsePingColor = "symbol_use_ping_color",
    SymbolType = {
        None = "none",
        Circle = "circle",
    }
}

return SettingNames
