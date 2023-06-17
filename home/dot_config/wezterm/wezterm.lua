local wezterm = require 'wezterm'

local config = {}

-- Font
config.font = wezterm.font 'Hack Nerd Font'
config.font_size = 16.0

config.color_scheme = 'nord'

local act = wezterm.action
config.keys = {
  {
    key = "LeftArrow",
    mods = "CTRL",
    action = act.SendKey {
      key = "b",
      mods = "META",
    },
  },
  {
    key = "RightArrow",
    mods = "CTRL",
    action = act.SendKey {
      key = "f",
      mods = "META",
    },
  },
}

return config
