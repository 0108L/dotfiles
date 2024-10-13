local wezterm = require("wezterm")

local config = {}

if wezterm.config_builder then
	config = wezterm.config_builder()
end

-- config.color_scheme = "Cambel(Gogh)"
config.color_scheme = "OneDark (base16)"
-- config.color_scheme = 'Tokyo Night Moon'

config.enable_tab_bar = true
config.hide_tab_bar_if_only_one_tab = false
config.show_tab_index_in_tab_bar = false -- 不展示tab的序号
config.tab_bar_at_bottom = true
config.tab_max_width = 25

--PERF: font
config.font_size = 14
config.freetype_load_target = "Light" --

local act = wezterm.action
config.mouse_bindings = {
	{
		event = {
			Down = {
				streak = 1,
				button = "Right",
			},
		},
		mods = "NONE",
		action = act({
			PasteFrom = "Clipboard",
		}),
	},
	{
		event = {
			Up = {
				streak = 1,
				button = "Left",
			},
		},
		mods = "NONE",
		action = act({
			CompleteSelection = "PrimarySelection",
		}),
	},
	{ -- Ctrl+Click open hyprlinks
		event = {
			Up = {
				streak = 1,
				button = "Left",
			},
		},
		mods = "CTRL",
		action = "OpenLinkAtMouseCursor",
	},
}

--PERF: keybindings
config.leader = { key = "b", mods = "CTRL|ALT", timeout_milliseconds = 1000 }
-- config.leader = { key = "d", mods = "ALT", timeout_milliseconds = 1000 }
config.keys = {
	{ key = "Enter",      mods = "CTRL|SHIFT",   action = act({ SpawnTab = "DefaultDomain" }) },
	{ key = "LeftArrow",  mods = "CTRL|SHIFT",   action = act({ ActivateTabRelative = -1 }) },
	{ key = "RightArrow", mods = "CTRL|SHIFT",   action = act({ ActivateTabRelative = 1 }) },
	{ key = "Backslash",  mods = "LEADER",       action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
	{ key = "Backslash",  mods = "LEADER|SHIFT", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
	{ key = "h",          mods = "ALT|SHIFT",    action = act({ AdjustPaneSize = { "Left", 2 } }) },
	{ key = "l",          mods = "ALT|SHIFT",    action = act({ AdjustPaneSize = { "Right", 2 } }) },
	{ key = "j",          mods = "ALT|SHIFT",    action = act({ AdjustPaneSize = { "Down", 1 } }) },
	{ key = "k",          mods = "ALT|SHIFT",    action = act({ AdjustPaneSize = { "Up", 1 } }) },
	{ key = "h",          mods = "CTRL|SHIFT",   action = act({ ActivatePaneDirection = "Left" }) },
	{ key = "l",          mods = "CTRL|SHIFT",   action = act({ ActivatePaneDirection = "Right" }) },
	{ key = "j",          mods = "CTRL|SHIFT",   action = act({ ActivatePaneDirection = "Down" }) },
	{ key = "k",          mods = "CTRL|SHIFT",   action = act({ ActivatePaneDirection = "Up" }) },
	{ key = "h",          mods = "LEADER",       action = act({ ActivatePaneDirection = "Left" }) },
	{ key = "l",          mods = "LEADER",       action = act({ ActivatePaneDirection = "Right" }) },
	{ key = "j",          mods = "LEADER",       action = act({ ActivatePaneDirection = "Down" }) },
	{ key = "k",          mods = "LEADER",       action = act({ ActivatePaneDirection = "Up" }) },
	{ key = "Q",          mods = "CTRL|SHIFT",   action = act.CloseCurrentTab({ confirm = true }) },
}
for i = 1, 9 do
	table.insert(config.keys, {
		key = tostring(i),
		mods = "ALT",
		action = act({ ActivateTab = i - 1 }),
	})
end

return config
