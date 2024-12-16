return {
	run = function()
		fassert(rawget(_G, "new_mod"), "`DisplayPing` encountered an error loading the Darktide Mod Framework.")

		new_mod("DisplayPing", {
			mod_script       = "DisplayPing/scripts/DisplayPing",
			mod_data         = "DisplayPing/scripts/DisplayPing_data",
			mod_localization = "DisplayPing/scripts/DisplayPing_localization",
		})
	end,
	packages = {},
}
