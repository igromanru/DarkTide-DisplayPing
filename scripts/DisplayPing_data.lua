--[[
    Author: Igromanru
    Date: 16.12.2024
    Mod Name: Display Ping
]]
local mod = get_mod("DisplayPing")
mod.Colors = mod:io_dofile("DisplayPing/scripts/ModUtils/Colors")

local SettingNames = mod:io_dofile("DisplayPing/scripts/setting_names")

local color_options = {}
for _, color_entity in ipairs(mod.Colors.get_entities()) do
	table.insert(color_options, {
		text = color_entity.color_name,
		value = color_entity.color_name
	})
end

local function clone_color_options()
	return table.clone(color_options)
end

return {
	name = mod:localize("mod_name"),
	description = mod:localize("mod_description"),
	is_togglable = true,
	allow_rehooking = true,
	options = {
		widgets = {
			{
				setting_id = SettingNames.TacticalOverlayOnly,
				type = "checkbox",
				default_value = true
			},
			{
				setting_id = SettingNames.HideInLobby,
				tooltip = SettingNames.HideInLobbyTooltip,
				type = "checkbox",
				default_value = false
			},
			{
				setting_id = SettingNames.ShowAveragePing,
				tooltip = SettingNames.ShowAveragePingTooltip,
				type = "checkbox",
				default_value = false
			},
			{
				setting_id = SettingNames.ShowAveragePingTimeFrame,
				type = "numeric",
				default_value = 20,
				range = { 5, 60 },
			},
			{
				setting_id = SettingNames.PositionOnScreen,
				type = "group",
				sub_widgets =
				{
					{
						setting_id = SettingNames.CustomHudMode,
						tooltip = SettingNames.CustomHudModeTooltip,
						type = "checkbox",
						default_value = false
					},
					{
						setting_id = SettingNames.PingHorizontalAlignment,
						type = "dropdown",
						default_value = "center",
						options = {
							{ text = "center", value = "center" },
							{ text = "left",   value = "left" },
							{ text = "right",  value = "right" },
						},
					},
					{
						setting_id = SettingNames.PingVerticalAlignment,
						type = "dropdown",
						default_value = "top",
						options = {
							{ text = "center", value = "center" },
							{ text = "top",    value = "top" },
							{ text = "bottom", value = "bottom" },
						},
					},
					{
						setting_id = SettingNames.PingXOffset,
						type = "numeric",
						default_value = 0,
						range = { -300, 300 },
					},
					{
						setting_id = SettingNames.PingYOffset,
						type = "numeric",
						default_value = 20,
						range = { -300, 300 },
					},
				}
			},
			{
				setting_id = SettingNames.PingStyleGroup,
				type = "group",
				sub_widgets =
				{
					{
						setting_id = SettingNames.PingFontSize,
						type = "numeric",
						default_value = 30,
						range = { 10, 50 },
					},
					{
						setting_id = SettingNames.PingDefaultColor,
						type = "dropdown",
						options = clone_color_options(),
						default_value = "white",
					},
				}
			},
			{
				setting_id = SettingNames.LabelStyleGroup,
				type = "group",
				sub_widgets =
				{
					{
						setting_id = SettingNames.PingLabel,
						type = "dropdown",
						default_value = SettingNames.PingLabels.None,
						options = {
							{ text = SettingNames.PingLabels.None,    value = SettingNames.PingLabels.None },
							{ text = SettingNames.PingLabels.Ping,    value = SettingNames.PingLabels.Ping },
							{ text = SettingNames.PingLabels.Latency, value = SettingNames.PingLabels.Latency },
							{ text = SettingNames.PingLabels.MS,      value = SettingNames.PingLabels.MS },
						},
					},
					{
						setting_id = SettingNames.LabelSidePosition,
						type = "dropdown",
						default_value = SettingNames.Sides.Left,
						options = {
							{ text = SettingNames.Sides.Left,  value = SettingNames.Sides.Left },
							{ text = SettingNames.Sides.Right, value = SettingNames.Sides.Right },
						},
					},
					{
						setting_id = SettingNames.LabelFontSize,
						type = "numeric",
						default_value = 30,
						range = { 10, 50 },
					},
					{
						setting_id = SettingNames.LabelOffsetToPing,
						type = "numeric",
						default_value = 0,
						range = { -30, 30 },
					},
					{
						setting_id = SettingNames.LabelYOffset,
						type = "numeric",
						default_value = 0,
						range = { -10, 10 },
					},
					{
						setting_id = SettingNames.LabelUsePingColor,
						type = "checkbox",
						default_value = false
					},
					{
						setting_id = SettingNames.LabelDefaultColor,
						type = "dropdown",
						options = clone_color_options(),
						default_value = "white",
					},
				}
			},
			{
				setting_id = SettingNames.SymbolGroup,
				type = "group",
				sub_widgets =
				{
					{
						setting_id = SettingNames.Symbol,
						type = "dropdown",
						default_value = SettingNames.SymbolType.None,
						options = {
							{ text = SettingNames.SymbolType.None,   value = SettingNames.SymbolType.None },
							{ text = SettingNames.SymbolType.Circle, value = SettingNames.SymbolType.Circle },
						},
					},
					{
						setting_id = SettingNames.SymbolSidePosition,
						type = "dropdown",
						default_value = SettingNames.Sides.Left,
						options = {
							{ text = SettingNames.Sides.Left,  value = SettingNames.Sides.Left },
							{ text = SettingNames.Sides.Right, value = SettingNames.Sides.Right },
						},
					},
					{
						setting_id = SettingNames.SymbolSize,
						type = "numeric",
						default_value = 20,
						range = { 5, 50 },
					},
					{
						setting_id = SettingNames.SymbolOffsetToPing,
						type = "numeric",
						default_value = 0,
						range = { -30, 30 },
					},
					{
						setting_id = SettingNames.SymbolYOffset,
						type = "numeric",
						default_value = 0,
						range = { -10, 10 },
					},
					{
						setting_id = SettingNames.SymbolUsePingColor,
						type = "checkbox",
						default_value = true
					},
					{
						setting_id = SettingNames.SymbolColor,
						type = "dropdown",
						options = clone_color_options(),
						default_value = "white",
					},
				}
			},
			{
				setting_id = SettingNames.PingRangeIndicatorGroup,
				type = "group",
				sub_widgets =
				{
					{
						setting_id = SettingNames.PingRangeIndicator,
						type = "checkbox",
						default_value = true
					},
					{
						setting_id = SettingNames.PingLowMinValue,
						type = "numeric",
						default_value = 10,
						range = { 1, 100 },
					},
					{
						setting_id = SettingNames.PingLowColor,
						type = "dropdown",
						options = clone_color_options(),
						default_value = "online_green",
					},
					{
						setting_id = SettingNames.PingMiddleMinValue,
						type = "numeric",
						default_value = 60,
						range = { 30, 200 },
					},
					{
						setting_id = SettingNames.PingMiddleColor,
						type = "dropdown",
						options = clone_color_options(),
						default_value = "yellow",
					},
					{
						setting_id = SettingNames.PingHighMinValue,
						type = "numeric",
						default_value = 100,
						range = { 50, 200 },
					},
					{
						setting_id = SettingNames.PingHighColor,
						type = "dropdown",
						options = clone_color_options(),
						default_value = "red",
					},
				}
			},
		}
	},
}
