--[[
    Author: Igromanru
    Date: 16.12.2024
    Mod Name: Display Ping
]]
local mod = get_mod("DisplayPing")
local SettingNames = mod:io_dofile("DisplayPing/scripts/setting_names")
local InputUtils = require("scripts/managers/input/input_utils")

local localizations = {
  mod_name = {
    en = "Display Ping",
  },
  mod_description = {
    en = "Displays your current ping",
  },
  [SettingNames.EnableMod] = {
    en = "Enable",
	["zh-cn"] = "开启",
  },
  [SettingNames.TacticalOverlayOnly] = {
    en = "Show only in tactical overlay",
	["zh-cn"] = "仅在Tab页面显示",
  },
  [SettingNames.HideInLobby] = {
    en = "Hide while in Mourningstar",
	["zh-cn"] = "处于大厅时隐藏延迟信息",
  },
  [SettingNames.HideInLobbyTooltip] = {
    en = "Shows Ping only in tactical overlay while in Mourningstar",
	["zh-cn"] = "当处于大厅时，仅在Tab页面显示延迟信息",
  },
  [SettingNames.ShowAveragePing] = {
    en = "Show Average Ping",
	["zh-cn"] = "显示平均延迟",
  },
  [SettingNames.ShowAveragePingTooltip] = {
    en = "Shows average ping in selected time frame. When disabled, the mod displays last measurement.",
	["zh-cn"] = "显示选定时间范围内的平均延迟。禁用该选项后，仅显示当前的延迟",
  },
  [SettingNames.ShowAveragePingTimeFrame] = {
    en = "Average Ping time frame in seconds",
	["zh-cn"] = "设定时间范围",
  },
  [SettingNames.PositionOnScreen] = {
    en = "Position on Screen",
	["zh-cn"] = "设置屏幕上所处的位置",
  },
  [SettingNames.CustomHudMode] = {
    en = "Custom HUD Mode",
	["zh-cn"] = "Custom HUD 模式",
  },
  [SettingNames.PingHorizontalAlignment] = {
    en = "Horizontal Alignment",
	["zh-cn"] = "水平对齐",
  },
  [SettingNames.PingVerticalAlignment] = {
    en = "Vertical Alignment",
	["zh-cn"] = "垂直对齐",
  },
  [SettingNames.CustomHudModeTooltip] = {
    en = "Prevents the mod from updating it's position on the screen, which allows other mods, like Custom HUD, to manage it.",
	["zh-cn"] = "为防止因MOD更新导致屏幕上所在的位置发生改变，开启此选项可允许由其他MOD管理（例如Custom HUD）",
  },
  [SettingNames.PingXOffset] = {
    en = "X Offset",
	["zh-cn"] = "X轴偏移值",
  },
  [SettingNames.PingYOffset] = {
    en = "Y Offset",
	["zh-cn"] = "Y轴偏移值",
  },
  [SettingNames.PingStyleGroup] = {
    en = "Ping Style Settings",
	["zh-cn"] = "设置延迟样式",
  },
  [SettingNames.PingFontSize] = {
    en = "Text Size",
	["zh-cn"] = "文字大小",
  },
  [SettingNames.PingLabel] = {
    en = "Label",
	["zh-cn"] = "文字",
  },
  [SettingNames.PingDefaultColor] = {
    en = "Default Color",
	["zh-cn"] = "默认颜色",
  },
  [SettingNames.PingRangeIndicatorGroup] = {
    en = "Dynamic Color Range",
	["zh-cn"] = "动态颜色范围",
  },
  [SettingNames.PingRangeIndicator] = {
    en = "Enable Dynamic Color Range",
	["zh-cn"] = "启用动态颜色范围",
  },
  [SettingNames.PingLowColor] = {
    en = "Low Ping Color",
	["zh-cn"] = "低延迟颜色",
  },
  [SettingNames.PingMiddleColor] = {
    en = "Acceptable Ping Color",
	["zh-cn"] = "中等延迟颜色",
  },
  [SettingNames.PingHighColor] = {
    en = "High Ping Color",
	["zh-cn"] = "高延迟颜色",
  },
  [SettingNames.PingLowMinValue] = {
    en = "Low Ping Range Start",
	["zh-cn"] = "低延迟初始值",
  },
  [SettingNames.PingMiddleMinValue] = {
    en = "Acceptable Ping Range Start",
	["zh-cn"] = "中等延迟初始值",
  },
  [SettingNames.PingHighMinValue] = {
    en = "High Ping Range Start",
	["zh-cn"] = "高延迟初始值",
  },
  [SettingNames.PingLabels.None] = {
    en = "- none -",
	["zh-cn"] = "无",
  },
  [SettingNames.PingLabels.Ping] = {
    en = "Ping",
	["zh-cn"] = "Ping",
  },
  [SettingNames.PingLabels.Latency] = {
    en = "Latency",
	["zh-cn"] = "Latency",
  },
  [SettingNames.PingLabels.MS] = {
    en = "ms",
	["zh-cn"] = "ms",
  },
  [SettingNames.LabelStyleGroup] = {
    en = "Label Style Settings",
	["zh-cn"] = "设置文字样式",
  },
  [SettingNames.LabelFontSize] = {
    en = "Text Size",
	["zh-cn"] = "文字大小",
  },
  [SettingNames.LabelDefaultColor] = {
    en = "Color",
	["zh-cn"] = "颜色",
  },
  [SettingNames.LabelSidePosition] = {
    en = "Position relative to Ping",
	["zh-cn"] = "位置",
  },
  [SettingNames.LabelOffsetToPing] = {
    en = "Gap size between Ping",
	["zh-cn"] = "文字间距",
  },
  [SettingNames.LabelYOffset] = {
    en = "Y Offset",
	["zh-cn"] = "Y轴偏移值",
  },
  [SettingNames.LabelUsePingColor] = {
    en = "Match Ping's Color",
	["zh-cn"] = "参照延迟颜色",
  },
  [SettingNames.SymbolGroup] = {
    en = "Symbol Style Settings",
	["zh-cn"] = "设置符号样式",
  },
  [SettingNames.Symbol] = {
    en = "Symbol",
	["zh-cn"] = "符号",
  },
  [SettingNames.SymbolSize] = {
    en = "Symbol Size",
	["zh-cn"] = "符号大小",
  },
  [SettingNames.SymbolSidePosition] = {
    en = "Position relative to Ping",
	["zh-cn"] = "符号位置",
  },
  [SettingNames.SymbolColor] = {
    en = "Color",
	["zh-cn"] = "符号颜色",
  },
  [SettingNames.SymbolOffsetToPing] = {
    en = "Gap size between Ping",
	["zh-cn"] = "间距",
  },
  [SettingNames.SymbolYOffset] = {
    en = "Y Offset",
	["zh-cn"] = "Y轴偏移值",
  },
  [SettingNames.SymbolUsePingColor] = {
    en = "Match Ping's Color",
	["zh-cn"] = "参照延迟颜色",
  },
  [SettingNames.SymbolType.Circle] = {
    en = "Circle",
	["zh-cn"] = "点状",
  },
  center = {
    en = "Center",
    de = "Mitte",
    ru = "Центр",
	["zh-cn"] = "中部",
  },
  left = {
    en = "Left",
    de = "Links",
    ru = "Слева",
	["zh-cn"] = "左",
  },
  right = {
    en = "Right",
    de = "Rechts",
    ru = "Справа",
	["zh-cn"] = "右",
  },
  top = {
    en = "Top",
    de = "Oben",
    ru = "Вверху",
	["zh-cn"] = "上部",
  },
  bottom = {
    en = "Bottom",
    de = "Unten",
    ru = "Внизу",
	["zh-cn"] = "下部",
  },
}

local function color_name_to_readable_text(color_name)
    local words = {}
    for word in string.gmatch(color_name, "([^_]+)") do
        table.insert(words, word)
    end

    for i, word in ipairs(words) do
        words[i] = word:sub(1,1):upper() .. word:sub(2):lower()
    end

    return table.concat(words, " ")
end

for i, color_name in ipairs(Color.list) do
    local color_values = Color[color_name](255, true)
    local text = InputUtils.apply_color_to_input_text(color_name_to_readable_text(color_name), color_values)
    localizations[color_name] = {
        en = text
    }
end

return localizations
