-- Pull in the wezterm API
local wezterm = require 'wezterm'
local wayland_cursor = require 'wayland_cursor'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices
config.default_prog = { '/usr/bin/fish', '-l' }

wayland_cursor.apply_to_config(config)

config.color_scheme = 'Tokyo Night'
config.font = wezterm.font "Hack Nerd Font Mono"

config.initial_rows = 40
config.initial_cols = 132

config.launch_menu = {
  {
    label = 'Zsh',
    args = { 'zsh', '-l' },
  },
  {
    label = 'Bash',
    args = { 'bash', '-l' },
  }
}

-- and finally, return the configuration to wezterm
return config
