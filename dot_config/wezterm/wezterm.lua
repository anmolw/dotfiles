-- Pull in the wezterm API
local wezterm = require 'wezterm'

local bindings = require 'bindings'
local wayland_cursor = require 'wayland_cursor'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices
bindings.apply_to_config(config)

-- Linux-specific configuration
if wezterm.target_triple == 'x86_64-unknown-linux-gnu' then
  wayland_cursor.apply_to_config(config)
  config.default_prog = { '/usr/bin/fish', '-l' }
-- Windows-specific configuration
elseif wezterm.target_triple == 'x86_64-pc-windows-msvc' then
  config.default_prog = { 'pwsh' }
end

config.color_scheme = 'Catppuccin Mocha'
config.font = wezterm.font 'Hack Nerd Font Mono'

-- No ligatures
config.harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' }

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
