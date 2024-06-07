local wezterm = require("wezterm")

local act = wezterm.action

local config = wezterm.config_builder()

config.color_scheme = "Kanagawa (Gogh)"

config.enable_wayland = false

config.enable_tab_bar = false

config.window_padding = {
	left = 5,
	right = 5,
	top = 5,
	bottom = 5,
}

-- config.colors = {
-- 	background = "#16161d",
-- }

config.window_close_confirmation = "NeverPrompt"

local copy_mode = nil

if wezterm.gui then
	copy_mode = wezterm.gui.default_key_tables().copy_mode
	table.insert(copy_mode, {
		key = "L",
		mods = "SHIFT",
		action = act.CopyMode("MoveToEndOfLineContent"),
	})

	table.insert(copy_mode, {
		key = "H",
		mods = "SHIFT",
		action = act.CopyMode("MoveToStartOfLineContent"),
	})
end

config.key_tables = {
	copy_mode = copy_mode,
}

config.force_reverse_video_cursor = true

config.cell_width = 0.85

config.front_end = "WebGpu"

config.font = wezterm.font("JetBrains Mono")

-- config.cursor_blink_rate = 500

-- config.cursor_blink_ease_in = "Constant"

-- config.cursor_blink_ease_out = "Constant"

-- config.default_cursor_style = "BlinkingBlock"

config.warn_about_missing_glyphs = false

config.harfbuzz_features = { "calt=0", "clig=0", "liga=0" }

return config
