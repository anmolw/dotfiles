local wezterm = require 'wezterm'
local module = {}

--- Taken from https://github.com/wez/wezterm/issues/1742#issuecomment-1075333507
function module.apply_to_config(config)
	local success, stdout, stderr = wezterm.run_child_process({"gsettings", "get", "org.gnome.desktop.interface", "cursor-theme"})
	if success then
	  config.xcursor_theme = stdout:gsub("'(.+)'\n", "%1")
	end
	
	local success, stdout, stderr = wezterm.run_child_process({"gsettings", "get", "org.gnome.desktop.interface", "cursor-size"})
	if success then
	  config.xcursor_size = tonumber(stdout)
	end
end

return module