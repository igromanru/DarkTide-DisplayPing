--[[
    Author: Igromanru
    Date: 16.12.2024
    Mod Name: Display Ping
]]
local mod = get_mod("DisplayPing")
local SettingNames = mod:io_dofile("DisplayPing/scripts/setting_names")

return {
	name = mod:localize("mod_name"),
	description = mod:localize("mod_description"),
	is_togglable = true,
	allow_rehooking = true,
	options = {
		widgets = {
			{
				setting_id = SettingNames.EnableMod,
				type = "checkbox",
				default_value = true
			},
			{
				setting_id = SettingNames.TacticalOverlayOnly,
				type = "checkbox",
				default_value = true
			},
			{
				setting_id = SettingNames.PingHorizontalAlignment,
				type = "dropdown",
				default_value = "center",
				options = {
					{text = "center", value = "center"},
					{text = "left", value = "left"},
					{text = "right", value = "right"},
				  },
			},
			{
				setting_id = SettingNames.PingVerticalAlignment,
				type = "dropdown",
				default_value = "top",
				options = {
					{text = "center", value = "center"},
					{text = "top", value = "top"},
					{text = "bottom", value = "bottom"},
				  },
			},
			{
				setting_id = SettingNames.PingXOffset,
				type = "numeric",
				default_value = 0,
				range = {-300, 300},
			},
			{
				setting_id = SettingNames.PingYOffset,
				type = "numeric",
				default_value = 20,
				range = {-300, 300},
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
						range = {10, 50},
					},
					{
						setting_id = SettingNames.PingColorR,
						type = "numeric",
						default_value = 255,
						range = {0, 255},
						decimals_number = 0
					},
					{
						setting_id = SettingNames.PingColorG,
						type = "numeric",
						default_value = 255,
						range = {0, 255},
						decimals_number = 0
					},
					{
						setting_id = SettingNames.PingColorB,
						type = "numeric",
						default_value = 255,
						range = {0, 255},
						decimals_number = 0
					},
				}
			},
		}
	},
}
