--[[
    Author: Igromanru
    Date: 16.12.2024
    Mod Name: Display Ping
]]
local mod = get_mod("DisplayPing")
local SettingNames = mod:io_dofile("DisplayPing/scripts/setting_names")
local InputUtils = require("scripts/managers/input/input_utils")

local localizations = {
  mod_name =
  {
    en = "Display Ping",
  },
  mod_description =
  {
    en = "Displays your current ping",
  },
  [SettingNames.EnableMod] = {
    en = "Enable"
  },
  [SettingNames.TacticalOverlayOnly] = {
    en = "Show only in tactical overlay"
  },
  [SettingNames.PingHorizontalAlignment] = {
    en = "Horizontal Alignment"
  },
  [SettingNames.PingVerticalAlignment] = {
    en = "Vertical Alignment"
  },
  [SettingNames.PingXOffset] = {
    en = "X Offset"
  },
  [SettingNames.PingYOffset] = {
    en = "Y Offset"
  },
  [SettingNames.PingStyleGroup] = {
    en = "Default Style Settings"
  },
  [SettingNames.PingFontSize] = {
    en = "Text Size"
  },
  [SettingNames.PingDefaultColor] = {
    en = "Default Color"
  },
  [SettingNames.PingRangeIndicatorGroup] = {
    en = "Dynamic Color Range"
  },
  [SettingNames.PingRangeIndicator] = {
    en = "Enable Dynamic Color Range"
  },
  [SettingNames.PingLowColor] = {
    en = "Low Ping Color"
  },
  [SettingNames.PingMiddleColor] = {
    en = "Middle Ping Color"
  },
  [SettingNames.PingHighColor] = {
    en = "High Ping Color"
  },
  center = {
    en = "Center",
    de = "Mitte",
    ru = "Центр",
  },
  left = {
    en = "Left",
    de = "Links",
    ru = "Слева",
  },
  right = {
    en = "Right",
    de = "Rechts",
    ru = "Справа",
  },
  top = {
    en = "Top",
    de = "Oben",
    ru = "Вверху",
  },
  bottom = {
    en = "Bottom",
    de = "Unten",
    ru = "Внизу",
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