---------------------
--- LOOK AND FEEL ---
---------------------

local colors = require("conf.colors")

-- Refer to https://wiki.hypr.land/Configuring/Basics/Variables/
hl.config({
	ecosystem = {
		no_update_news = true,
	},

	-- https://wiki.hypr.land/Configuring/Basics/Variables/#general
	general = {
		gaps_in = 2,
		gaps_out = 4,
		border_size = 2,

		-- See https://wiki.hypr.land/Configuring/Basics/Variables/#variable-types for color syntax.
		col = {
			active_border = {
				colors = { colors.primary, colors.secondary },
				angle = 45,
			},
			inactive_border = colors.inverse_on_surface,
		},

		-- Set to true to resize windows by clicking and dragging borders and gaps.
		resize_on_border = false,

		-- Read https://wiki.hypr.land/Configuring/Advanced-and-Cool/Tearing/ before enabling tearing.
		-- allow_tearing = false,
		allow_tearing = true,

		-- layout = "dwindle",
		layout = "scrolling",
	},

	-- https://wiki.hypr.land/Configuring/Basics/Variables/#decoration
	decoration = {
		rounding = 10,
		rounding_power = 2,

		-- Change the transparency of focused and unfocused windows.
		active_opacity = 1.0,
		inactive_opacity = 0.98,

		shadow = {
			-- These were disabled by the final overrides in hyprland.conf.
			enabled = false,
			range = 4,
			render_power = 3,
			color = "rgba(1a1a1aee)",
		},

		-- https://wiki.hypr.land/Configuring/Basics/Variables/#blur
		blur = {
			enabled = false,
			size = 3,
			passes = 1,
			vibrancy = 0.1696,
		},
	},

	animations = {
		enabled = true,
	},

	xwayland = {
		-- Testing.
		force_zero_scaling = true,
		-- use_nearest_neighbor = true,
		-- use_nearest_neighbor = false,
	},

	-- See https://wiki.hypr.land/Configuring/Layouts/Dwindle-Layout/ for more.
	dwindle = {
		-- Pseudotiling is toggled per window with SUPER+SHIFT+P in binds.lua.
		-- preserve_split keeps the split direction when opening another window.
		preserve_split = true,
	},

	-- See https://wiki.hypr.land/Configuring/Layouts/Master-Layout/ for more.
	master = {
		new_status = "master",
	},

	-- See https://wiki.hypr.land/Configuring/Layouts/Scrolling-Layout/ for more.
	scrolling = {
		column_width = 0.333,
		direction = "right",
	},

	-- https://wiki.hypr.land/Configuring/Basics/Variables/#misc
	misc = {
		-- Allow recovering a session lock after a crash.
		allow_session_lock_restore = true,
		-- Disable the default mascot wallpapers and Hyprland logo.
		force_default_wallpaper = -1,
		disable_hyprland_logo = true,
		-- Do not map middle-click (the scroll-wheel button) to paste.
		middle_click_paste = false,
	},

	cursor = {
		-- Auto-select software cursors when required by the driver.
		no_hardware_cursors = 2,
	},
})

-- https://wiki.hypr.land/Configuring/Advanced-and-Cool/Animations/
--
-- Previous animation preset (disabled). Every line remains valid Lua if restored.
-- hl.curve("wind", { type = "bezier", points = { { 0.05, 0.85 }, { 0.03, 0.97 } } })
-- hl.curve("winIn", { type = "bezier", points = { { 0.07, 0.88 }, { 0.04, 0.99 } } })
-- hl.curve("winOut", { type = "bezier", points = { { 0.20, -0.15 }, { 0, 1 } } })
-- hl.curve("liner", { type = "bezier", points = { { 1, 1 }, { 1, 1 } } })
-- hl.curve("md3_standard", { type = "bezier", points = { { 0.12, 0 }, { 0, 1 } } })
-- hl.curve("md3_decel", { type = "bezier", points = { { 0.05, 0.80 }, { 0.10, 0.97 } } })
-- hl.curve("md3_accel", { type = "bezier", points = { { 0.20, 0 }, { 0.80, 0.08 } } })
-- hl.curve("overshot", { type = "bezier", points = { { 0.05, 0.85 }, { 0.07, 1.04 } } })
-- hl.curve("crazyshot", { type = "bezier", points = { { 0.1, 1.22 }, { 0.68, 0.98 } } })
-- hl.curve("hyprnostretch", { type = "bezier", points = { { 0.05, 0.82 }, { 0.03, 0.94 } } })
-- hl.curve("menu_decel", { type = "bezier", points = { { 0.05, 0.82 }, { 0, 1 } } })
-- hl.curve("menu_accel", { type = "bezier", points = { { 0.20, 0 }, { 0.82, 0.10 } } })
-- hl.curve("easeInOutCirc", { type = "bezier", points = { { 0.75, 0 }, { 0.15, 1 } } })
-- hl.curve("easeOutCirc", { type = "bezier", points = { { 0, 0.48 }, { 0.38, 1 } } })
-- hl.curve("easeOutExpo", { type = "bezier", points = { { 0.10, 0.94 }, { 0.23, 0.98 } } })
-- hl.curve("softAcDecel", { type = "bezier", points = { { 0.20, 0.20 }, { 0.15, 1 } } })
-- hl.curve("md2", { type = "bezier", points = { { 0.30, 0 }, { 0.15, 1 } } })
-- hl.curve("OutBack", { type = "bezier", points = { { 0.28, 1.40 }, { 0.58, 1 } } })
-- hl.curve("easeInOutCirc", { type = "bezier", points = { { 0.78, 0 }, { 0.15, 1 } } })
-- hl.animation({ leaf = "border", enabled = true, speed = 1.6, bezier = "liner" })
-- hl.animation({ leaf = "borderangle", enabled = true, speed = 82, bezier = "liner", style = "loop" })
-- hl.animation({ leaf = "windowsIn", enabled = true, speed = 3.2, bezier = "winIn", style = "slide" })
-- hl.animation({ leaf = "windowsOut", enabled = true, speed = 2.8, bezier = "easeOutCirc" })
-- hl.animation({ leaf = "windowsMove", enabled = true, speed = 3.0, bezier = "wind", style = "slide" })
-- hl.animation({ leaf = "fade", enabled = true, speed = 1.8, bezier = "md3_decel" })
-- hl.animation({ leaf = "layersIn", enabled = true, speed = 1.8, bezier = "menu_decel", style = "slide" })
-- hl.animation({ leaf = "layersOut", enabled = true, speed = 1.5, bezier = "menu_accel" })
-- hl.animation({ leaf = "fadeLayersIn", enabled = true, speed = 1.6, bezier = "menu_decel" })
-- hl.animation({ leaf = "fadeLayersOut", enabled = true, speed = 1.8, bezier = "menu_accel" })
-- hl.animation({ leaf = "workspaces", enabled = true, speed = 4.0, bezier = "menu_decel", style = "slide" })
-- hl.animation({ leaf = "specialWorkspace", enabled = true, speed = 2.3, bezier = "md3_decel", style = "slidefadevert 15%" })

-- Active animation preset.
hl.curve("bounce", {
	type = "bezier",
	points = { { 0.0, 1.25 }, { 0.15, 1.0 } },
})
hl.curve("buttery", {
	type = "bezier",
	points = { { 0.1, 1.15 }, { 0.15, 1.02 } },
})
hl.curve("smooth", {
	type = "bezier",
	points = { { 0.0, 0.0 }, { 0.12, 1.0 } },
})
hl.curve("linear", {
	type = "bezier",
	points = { { 0.0, 0.0 }, { 1.0, 1.0 } },
})

hl.animation({ leaf = "windowsIn", enabled = true, speed = 4.5, bezier = "bounce", style = "slide" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 3.5, bezier = "smooth", style = "slide" })
hl.animation({ leaf = "windowsMove", enabled = true, speed = 4, bezier = "buttery", style = "slide" })
hl.animation({ leaf = "fadeIn", enabled = true, speed = 3.5, bezier = "smooth" })
hl.animation({ leaf = "fadeOut", enabled = true, speed = 3, bezier = "smooth" })
hl.animation({ leaf = "fadeDim", enabled = true, speed = 4, bezier = "smooth" })
hl.animation({ leaf = "fadeShadow", enabled = true, speed = 4, bezier = "smooth" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 4.5, bezier = "buttery", style = "slidefade 10%" })
hl.animation({
	leaf = "specialWorkspace",
	enabled = true,
	speed = 4.5,
	bezier = "buttery",
	style = "slidefadevert -15%",
})
hl.animation({ leaf = "border", enabled = true, speed = 7, bezier = "smooth" })
hl.animation({ leaf = "borderangle", enabled = true, speed = 35, bezier = "linear", style = "loop" })
hl.animation({ leaf = "layersIn", enabled = true, speed = 4, bezier = "bounce", style = "slide" })
hl.animation({ leaf = "layersOut", enabled = true, speed = 3, bezier = "smooth", style = "slide" })

-- Ref: https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/
-- "Smart gaps" / "no gaps when only one window".
-- s[false] prevents smart gaps from applying to special workspaces.
hl.workspace_rule({ workspace = "w[tv1]s[false]", gaps_out = 0, gaps_in = 0 })
hl.workspace_rule({ workspace = "f[1]s[false]", gaps_out = 0, gaps_in = 0 })
hl.window_rule({
	name = "smart-gaps-single-tiled",
	match = { float = false, workspace = "w[tv1]s[false]" },
	border_size = 0,
	rounding = 0,
})
hl.window_rule({
	name = "smart-gaps-fullscreen",
	match = { float = false, workspace = "f[1]s[false]" },
	border_size = 0,
	rounding = 0,
})
