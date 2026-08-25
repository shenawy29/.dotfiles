local wezterm = require("wezterm")
local config = wezterm.config_builder()

local workspace_cwd = {}

local mux = wezterm.mux
-- Default workspace starts wherever wezterm itself starts
wezterm.on("gui-startup", function(cmd)
	local cwd = cmd and cmd.cwd or wezterm.home_dir
	workspace_cwd["default"] = cwd
end)

wezterm.on("gui-startup", function(cmd)
	local default_cwd = wezterm.home_dir .. "/projects"

	local tab, pane, window = mux.spawn_window(cmd or {
		workspace = "default",
		cwd = default_cwd,
	})

	mux.set_active_workspace("default")
	workspace_cwd["default"] = default_cwd
end)

-- Whenever the smart_workspace_switcher plugin creates or switches
-- to a workspace via zoxide/project picking, remember its path
wezterm.on("smart_workspace_switcher.workspace_switcher.chosen", function(window, path)
	local name = window:active_workspace()
	workspace_cwd[name] = path
end)

wezterm.on("smart_workspace_switcher.workspace_switcher.created", function(window, path)
	local name = window:active_workspace()
	workspace_cwd[name] = path
end)

-- ─────────────────────────────────────────────
-- Plugins
-- ─────────────────────────────────────────────
local workspace_switcher = wezterm.plugin.require("https://github.com/MLFlexer/smart_workspace_switcher.wezterm")
local tabline = wezterm.plugin.require("https://github.com/michaelbrusegard/tabline.wez")
local smart_splits = wezterm.plugin.require("https://github.com/mrjones2014/smart-splits.nvim")
-- ─────────────────────────────────────────────
-- Appearance
-- ─────────────────────────────────────────────
config.default_gui_startup_args = { "start", "--always-new-process" }
config.color_scheme = "Kanagawa (Gogh)"
config.font = wezterm.font("FiraCode Nerd Font")
config.cell_width = 0.9
config.front_end = "WebGpu"
config.force_reverse_video_cursor = true
config.window_close_confirmation = "NeverPrompt"
config.window_padding = { left = 0, right = 0, top = 0, bottom = 0 }

config.cursor_blink_rate = 0
config.cursor_blink_ease_in = "Constant"
config.cursor_blink_ease_out = "Constant"
config.default_cursor_style = "BlinkingBlock"
config.hide_tab_bar_if_only_one_tab = false

config.animation_fps = 60
config.max_fps = 60

tabline.setup({
	options = {
		theme = "Kanagawa (Gogh)",
		theme_overrides = {
			tab = {
				active = {
					fg = "#dcd7ba",
					bg = "#1f1f28",
				},
				inactive = {
					fg = "#727169",
					bg = "#16161D",
				},
			},
		},
		section_separators = {
			left = "",
			right = "",
		},
		component_separators = {
			left = "",
			right = "",
		},
		tab_separators = {
			left = "",
			right = "",
		},
	},
	extensions = {},
})

tabline.apply_to_config(config)

config.window_decorations = "NONE"

-- ─────────────────────────────────────────────
-- Workspace switcher: restrict to ~/projects
-- ─────────────────────────────────────────────
workspace_switcher.get_choices = function(opts)
	local projects = {}
	local handle = io.popen("find " .. wezterm.home_dir .. "/projects -maxdepth 1 -mindepth 1 -type d")
	if handle then
		for line in handle:lines() do
			local name = line:match("([^/]+)$")
			table.insert(projects, { label = name, id = line })
		end
		handle:close()
	end

	-- Merge active workspaces to allow switching to already-open ones
	local active = workspace_switcher.choices.get_workspace_elements({})
	for _, w in ipairs(active) do
		local exists = false
		for _, p in ipairs(projects) do
			if p.label == w.label then
				exists = true
				break
			end
		end
		if not exists then
			table.insert(projects, w)
		end
	end

	return projects
end

config.leader = { key = "w", mods = "CTRL", timeout_milliseconds = 1000 }

local copy_mode = nil

if wezterm.gui then
	copy_mode = wezterm.gui.default_key_tables().copy_mode
	table.insert(copy_mode, { key = "h", mods = "SHIFT", action = wezterm.action.CopyMode("MoveToStartOfLineContent") })
	table.insert(copy_mode, { key = "l", mods = "SHIFT", action = wezterm.action.CopyMode("MoveToEndOfLineContent") })
end

config.key_tables = {
	copy_mode = copy_mode,

	resize_pane = {
		{ key = "h", action = wezterm.action.AdjustPaneSize({ "Left", 5 }) },
		{ key = "j", action = wezterm.action.AdjustPaneSize({ "Down", 5 }) },
		{ key = "k", action = wezterm.action.AdjustPaneSize({ "Up", 5 }) },
		{ key = "l", action = wezterm.action.AdjustPaneSize({ "Right", 5 }) },
		{ key = "Escape", action = wezterm.action.PopKeyTable },
		{ key = "q", action = wezterm.action.PopKeyTable },
	},

	session_mode = {
		{ key = "j", mods = "CTRL", action = wezterm.action.ScrollByLine(1) },
		{ key = "k", mods = "CTRL", action = wezterm.action.ScrollByLine(-1) },
		{ key = "Escape", action = wezterm.action.PopKeyTable },
	},
}

config.keys = {
	{ mods = "LEADER", key = "[", action = wezterm.action.ActivateCopyMode },

	-- ── Splits ──────────────────────────────────────────────────────────
	{ mods = "LEADER", key = "-", action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }) },
	{ mods = "LEADER", key = "\\", action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }) },

	-- ── Resize mode ─────────────────────────────────────────────────────
	{
		mods = "LEADER",
		key = "r",
		action = wezterm.action.ActivateKeyTable({ name = "resize_pane", one_shot = false }),
	},

	-- ── Tabs ─────────────────────────────────────────────────────────────
	{
		mods = "LEADER",
		key = "c",
		action = wezterm.action_callback(function(win, pane)
			local name = win:active_workspace()
			local cwd = workspace_cwd[name]
			if cwd then
				win:perform_action(
					wezterm.action.SpawnCommandInNewTab({ cwd = cwd, domain = "CurrentPaneDomain" }),
					pane
				)
			else
				-- fallback: no known project dir, just inherit as before
				win:perform_action(wezterm.action.SpawnTab("CurrentPaneDomain"), pane)
			end
		end),
	},
	{ mods = "LEADER", key = "n", action = wezterm.action.ActivateTabRelative(1) },
	{ mods = "LEADER", key = "p", action = wezterm.action.ActivateTabRelative(-1) },
	{ mods = "LEADER", key = "t", action = wezterm.action.ShowTabNavigator },
	{ mods = "LEADER", key = "1", action = wezterm.action.ActivateTab(0) },
	{ mods = "LEADER", key = "2", action = wezterm.action.ActivateTab(1) },
	{ mods = "LEADER", key = "3", action = wezterm.action.ActivateTab(2) },
	{ mods = "LEADER", key = "4", action = wezterm.action.ActivateTab(3) },
	{ mods = "LEADER", key = "5", action = wezterm.action.ActivateTab(4) },

	-- ── Workspaces ───────────────────────────────────────────────────────
	{ mods = "LEADER", key = "b", action = workspace_switcher.switch_to_prev_workspace() },
	--
	{
		mods = "CTRL",
		key = "f",
		action = wezterm.action_callback(function(win, pane)
			local choices = {}

			-- Active workspaces first
			for i, name in ipairs(wezterm.mux.get_workspace_names()) do
				table.insert(choices, {
					id = "workspace:" .. name,
					label = string.format("%d: 󱂬 %s", i, name),
				})
			end

			-- Then ~/projects dirs
			local handle = io.popen("find " .. wezterm.home_dir .. "/projects -maxdepth 1 -mindepth 1 -type d")
			if handle then
				local offset = #choices
				for line in handle:lines() do
					local name = line:match("([^/]+)$")
					-- Skip if already listed as active workspace
					local exists = false
					for _, c in ipairs(choices) do
						if c.id == "workspace:" .. name then
							exists = true
							break
						end
					end
					if not exists then
						offset = offset + 1
						table.insert(choices, {
							id = "project:" .. line,
							label = string.format("%d:  %s", offset, name),
						})
					end
				end
				handle:close()
			end

			win:perform_action(
				wezterm.action.InputSelector({
					title = "Switch / Create Workspace",
					choices = choices,
					fuzzy = true,
					alphabet = "1234567890",
					action = wezterm.action_callback(function(_, _, id, _)
						if not id then
							return
						end
						local kind, value = id:match("^([^:]+):(.*)")
						if kind == "workspace" then
							win:perform_action(wezterm.action.SwitchToWorkspace({ name = value }), pane)
						elseif kind == "project" then
							local name = value:match("([^/]+)$")
							workspace_cwd[name] = value
							win:perform_action(
								wezterm.action.SwitchToWorkspace({ name = name, spawn = { cwd = value } }),
								pane
							)
						end
					end),
				}),
				pane
			)
		end),
	},
	-- LEADER + w: view/switch workspaces with number shortcuts
	{
		mods = "LEADER",
		key = "s",
		action = wezterm.action_callback(function(win, pane)
			local workspaces = {}
			for i, name in ipairs(wezterm.mux.get_workspace_names()) do
				table.insert(workspaces, {
					id = name,
					label = string.format("%d: %s", i, name),
				})
			end
			win:perform_action(
				wezterm.action.InputSelector({
					title = "Workspaces",
					choices = workspaces,
					fuzzy = true,
					alphabet = "1234567890",
					action = wezterm.action_callback(function(_, _, id, _)
						if id then
							win:perform_action(wezterm.action.SwitchToWorkspace({ name = id }), pane)
						end
					end),
				}),
				pane
			)
		end),
	},

	-- LEADER + x: delete a workspace by number
	{
		mods = "LEADER",
		key = "x",
		action = wezterm.action_callback(function(win, pane)
			local choices = {}
			for i, name in ipairs(wezterm.mux.get_workspace_names()) do
				table.insert(choices, {
					id = name,
					label = string.format("%d: %s", i, name),
				})
			end
			win:perform_action(
				wezterm.action.InputSelector({
					title = "Delete Workspace",
					choices = choices,
					fuzzy = true,
					alphabet = "1234567890",
					action = wezterm.action_callback(function(inner_win, inner_pane, id, _)
						if not id then
							return
						end
						local current = wezterm.mux.get_active_workspace()
						if id == current then
							inner_win:perform_action(wezterm.action.SwitchWorkspaceRelative(1), inner_pane)
						end
						for _, w in ipairs(wezterm.mux.all_windows()) do
							if w:get_workspace() == id then
								for _, tab in ipairs(w:tabs()) do
									for _, p in ipairs(tab:panes()) do
										p:inject_output("\003")
										p:send_text("exit\n")
									end
								end
							end
						end
					end),
				}),
				pane
			)
		end),
	},
}

smart_splits.apply_to_config(config, {
	direction_keys = { "h", "j", "k", "l" },
	modifiers = {
		move = "CTRL",
	},
})

return config
