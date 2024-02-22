-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
config.color_scheme = "Kanagawa (Gogh)"

config.enable_tab_bar = false

config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}

config.freetype_load_flags = "NO_HINTING"

config.colors = {
	background = "#0E0E18",
}

config.window_close_confirmation = "NeverPrompt"

config.force_reverse_video_cursor = true

config.cell_width = 0.9

config.front_end = "WebGpu"

config.font = wezterm.font("JetBrains Mono")

config.cursor_blink_rate = 500

config.cursor_blink_ease_in = "Constant"

config.cursor_blink_ease_out = "Constant"

config.default_cursor_style = "BlinkingBlock"

config.harfbuzz_features = { "calt=0", "clig=0", "liga=0" }

return config
