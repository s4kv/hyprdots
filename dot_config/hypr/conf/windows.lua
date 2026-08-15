------------------------------
--- WINDOWS AND WORKSPACES ---
------------------------------

-- See https://wiki.hypr.land/Configuring/Basics/Window-Rules/ for window rules.
-- See https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/ for workspace rules.

-- Examples retained from the original configuration, translated to Lua:
-- hl.window_rule({ name = "example-kitty", match = { class = "^(kitty)$" }, float = true })
-- hl.window_rule({ name = "example-kitty-title", match = { class = "^(kitty)$", title = "^(kitty)$" }, float = true })

-- Ignore maximize requests from apps.
hl.window_rule({
	name = "suppress-maximize-requests",
	match = { class = ".*" },
	suppress_event = "maximize",
})

-- Fix dragging issues with XWayland windows that do not expose class/title data.
hl.window_rule({
	name = "fix-xwayland-drags",
	match = {
		class = "^$",
		title = "^$",
		xwayland = true,
		float = true,
		fullscreen = false,
		pin = false,
	},
	no_focus = true,
})

-- Steam games. Mark them as game content so VRR and automatic direct scanout
-- can activate. `immediate` completes the allow_tearing setup in conf/look.lua.
hl.window_rule({
	name = "steam-game",
	match = { class = "^steam_app_\\d+$" },
	fullscreen = true,
	monitor = "HDMI-A-1",
	workspace = "10",
	content = "game",
	immediate = true,
	no_anim = true,
})

-- For Steam, remove borders and rounding on workspace 10.
hl.workspace_rule({
	workspace = "10",
	no_border = true,
	no_rounding = true,
})

-- Balatro, osu!, Gamescope, and CS2 use the same game workspace as Steam.
for _, game in ipairs({
	{ name = "balatro", class = "^love$" },
	{ name = "osu", class = "^osu!$" },
	{ name = "gamescope", class = "^gamescope$" },
	{ name = "cs2", class = "^cs2$" },
}) do
	hl.window_rule({
		name = game.name,
		match = { class = game.class },
		fullscreen = true,
		monitor = "HDMI-A-1",
		workspace = "10",
		content = "game",
		immediate = true,
		no_anim = true,
	})
end

-- Window rule for Blueman and Pavucontrol.
hl.window_rule({
	name = "pavucontrol-blueman",
	match = { class = "^(blueman-manager|org.pulseaudio.pavucontrol)$" },
	float = true,
	size = { 850, 550 },
})

-- Window rule for downloads in Zen Browser.
hl.window_rule({
	name = "zen-downloads",
	match = { title = "^(Library)$" },
	float = true,
})

-- Make Kitty slightly transparent.
hl.window_rule({
	name = "kitty-opacity",
	match = { class = "kitty" },
	opacity = "0.99",
})

-- Make Microsoft Teams float.
hl.window_rule({
	name = "teams-floating",
	match = { class = "^(Microsoft Teams - Preview)$" },
	float = true,
})

-- Per-workspace layouts.
hl.workspace_rule({
	workspace = "s[true]",
	layout = "scrolling",
})
hl.workspace_rule({
	workspace = "1",
	layout_opts = { direction = "right" },
})
-- hl.workspace_rule({ workspace = "s[true]", layout_opts = { direction = "right" } })

-- Fix Zoom application windows.
hl.window_rule({
	name = "zoom-workplace-no-initial-focus",
	match = {
		class = "^(zoom)$",
		title = "^(Zoom Workplace)$",
	},
	no_initial_focus = true,
})

-- Previous no-initial-focus rules for Zoom menus (disabled):
-- hl.window_rule({
--     name = "zoom-menu-no-initial-focus",
--     match = { class = "^(zoom)$", title = "^(menu window)$" },
--     no_initial_focus = true,
-- })
-- hl.window_rule({
--     name = "zoom-confirm-no-initial-focus",
--     match = { class = "^(zoom)$", title = "^(confirm window)$" },
--     no_initial_focus = true,
-- })

-- Keep Zoom's transient menu and confirmation windows focused instead.
hl.window_rule({
	name = "zoom-menu-stay-focused",
	match = {
		class = "^(zoom)$",
		title = "^(menu window)$",
	},
	stay_focused = true,
})

hl.window_rule({
	name = "zoom-confirm-stay-focused",
	match = {
		class = "^(zoom)$",
		title = "^(confirm window)$",
	},
	stay_focused = true,
})

-- Disable the selection layer animation used by region capture tools.
hl.layer_rule({
	name = "selection-no-animation",
	match = { namespace = "selection" },
	no_anim = true,
})

-- disable terminal screensharing for mod + shift + return
hl.window_rule({
	name = "private-terminal",
	match = {
		title = "private terminal",
	},
	no_screen_share = true,
})
