-------------------
--- KEYBINDINGS ---
-------------------

-- See https://wiki.hypr.land/Configuring/Start/ and
-- https://wiki.hypr.land/Configuring/Basics/Binds/ for more.
local main_mod = "SUPER"

-- Programs.
-- local terminal = "kitty"
local terminal = "ghostty"
-- local file_manager = "dolphin"
local file_manager = "kitty -e tmux new-session yazi"
local menu = "~/.config/rofi/launcher/launcher.sh"
local browser = "zen-browser"
local monitors = require("conf.monitors")

local function bind(keys, dispatcher, description, flags)
	local options = {}
	for name, value in pairs(flags or {}) do
		options[name] = value
	end
	options.description = description
	return hl.bind(keys, dispatcher, options)
end

local function global_layout()
	local layout = hl.get_config("general.layout")
	return layout or "scrolling"
end

-- Native Lua replacement for scripts/smart_layout.sh. It checks the current
-- layout without spawning hyprctl for every focus, swap, or resize action.
local function current_layout()
	-- First use the active workspace's effective tiled layout.
	local workspace = hl.get_active_workspace()
	if workspace and workspace.tiled_layout then
		return workspace.tiled_layout
	end

	-- Fall back to the global layout when no workspace override is present.
	return global_layout()
end

local function relative_resize(width_factor, height_factor)
	local window = hl.get_active_window()
	if not window or not window.size then
		return
	end

	local width = window.size.x or window.size[1]
	local height = window.size.y or window.size[2]
	if not width or not height then
		return
	end

	hl.dispatch(hl.dsp.window.resize({
		x = math.floor(width * width_factor),
		y = math.floor(height * height_factor),
		relative = true,
		window = window,
	}))
end

local function smart_focus(direction)
	if current_layout() == "scrolling" then
		hl.dispatch(hl.dsp.layout("focus " .. direction))
	else
		hl.dispatch(hl.dsp.focus({ direction = direction }))
	end
end

-- Previous scrolling-layout swap experiment (disabled):
-- local function scrolling_column_swap(direction)
--     if current_layout() == "scrolling" and (direction == "l" or direction == "r") then
--         hl.dispatch(hl.dsp.layout("swapcol " .. direction))
--     else
--         hl.dispatch(hl.dsp.window.swap({ direction = direction }))
--     end
-- end
local function smart_swap(direction)
	hl.dispatch(hl.dsp.window.swap({ direction = direction }))
end

local function smart_resize(direction)
	if current_layout() == "scrolling" and direction == "l" then
		hl.dispatch(hl.dsp.layout("colresize +conf"))
	elseif current_layout() == "scrolling" and direction == "h" then
		hl.dispatch(hl.dsp.layout("colresize -conf"))
	elseif direction == "l" then
		relative_resize(0.33, 0)
	elseif direction == "h" then
		relative_resize(-0.33, 0)
	elseif direction == "k" then
		relative_resize(0, -0.33)
	elseif direction == "j" then
		relative_resize(0, 0.33)
	end
end

local function move_twice(first, second)
	hl.dispatch(hl.dsp.window.move({ direction = first }))
	hl.dispatch(hl.dsp.window.move({ direction = second }))
end

local function toggle_layout()
	local next_layout = global_layout() == "dwindle" and "scrolling" or "dwindle"
	hl.config({ general = { layout = next_layout } })

	if next_layout == "scrolling" then
		hl.timer(function()
			hl.dispatch(hl.dsp.layout("fit visible"))
		end, { timeout = 300, type = "oneshot" })
	end

	hl.notification.create({
		text = "Layout switched to: " .. (next_layout == "scrolling" and "Scrolling" or "Dwindle"),
		timeout = 2000,
		icon = "ok",
	})
end

-- Disable expensive compositor effects and lower the 240 Hz laptop panel to
-- 60 Hz. Capture the live values before entering power-saver mode so toggling
-- it off restores runtime customizations instead of assuming fixed defaults.
local power_saver_enabled = false
local normal_effects = nil

local function capture_normal_effects()
	return {
		animations = hl.get_config("animations.enabled"),
		blur = hl.get_config("decoration.blur.enabled"),
		shadow = hl.get_config("decoration.shadow.enabled"),
		glow = hl.get_config("decoration.glow.enabled"),
		rounding = hl.get_config("decoration.rounding"),
		active_opacity = hl.get_config("decoration.active_opacity"),
		inactive_opacity = hl.get_config("decoration.inactive_opacity"),
		vfr = hl.get_config("debug.vfr"),
	}
end

local function toggle_power_saver()
	if power_saver_enabled then
		hl.config({
			animations = { enabled = normal_effects.animations },
			decoration = {
				blur = { enabled = normal_effects.blur },
				shadow = { enabled = normal_effects.shadow },
				glow = { enabled = normal_effects.glow },
				rounding = normal_effects.rounding,
				active_opacity = normal_effects.active_opacity,
				inactive_opacity = normal_effects.inactive_opacity,
			},
			debug = { vfr = normal_effects.vfr },
		})

		-- A looping border-angle animation keeps rendering at the monitor's
		-- refresh rate even when animations.enabled is false, so restore it
		-- separately when returning to the normal profile.
		hl.animation({ leaf = "borderangle", enabled = true, speed = 35, bezier = "linear", style = "loop" })
	else
		normal_effects = capture_normal_effects()

		hl.config({
			animations = { enabled = false },
			decoration = {
				blur = { enabled = false },
				shadow = { enabled = false },
				glow = { enabled = false },
				rounding = 0,
				active_opacity = 1.0,
				inactive_opacity = 1.0,
			},
			debug = { vfr = true },
		})
		hl.animation({ leaf = "borderangle", enabled = false })
	end

	power_saver_enabled = not power_saver_enabled
	monitors.set_laptop_power_saving(power_saver_enabled)

	hl.notification.create({
		text = power_saver_enabled and "Power saver enabled: effects off, display at 60 Hz"
			or "Power saver disabled: normal effects and 240 Hz restored",
		timeout = 3000,
		icon = "ok",
	})
end

-- Example bindings retained from the original configuration:
-- bind(main_mod .. " + Q", hl.dsp.exec_cmd(terminal), "Open terminal")
-- bind(main_mod .. " + C", hl.dsp.window.close(), "Close active window")
-- bind(main_mod .. " + M", hl.dsp.exit(), "Exit Hyprland")
bind(main_mod .. " + Return", hl.dsp.exec_cmd(terminal), "Open terminal")
bind(main_mod .. " + W", hl.dsp.window.close(), "Close active window")
bind(main_mod .. " + E", hl.dsp.exec_cmd(file_manager), "Open file manager")
bind(main_mod .. " + M", hl.dsp.window.fullscreen({ mode = "maximized" }), "Toggle maximize")
bind(main_mod .. " + T", hl.dsp.window.float(), "Toggle floating")
bind(main_mod .. " + F", hl.dsp.window.fullscreen({ mode = "fullscreen" }), "Toggle fullscreen")
bind(main_mod .. " + Space", hl.dsp.exec_cmd(menu), "Open application launcher")
-- bind(main_mod .. " + C", hl.dsp.exec_cmd("/home/sakvi/.config/rofi/rofi-focus/rofi-focus.sh"), "Focus a window")
bind(main_mod .. " + SHIFT + P", hl.dsp.window.pseudo(), "Toggle pseudotile")
bind(main_mod .. " + CTRL + SHIFT + P", toggle_power_saver, "Toggle Hyprland power saver")
-- Dwindle alternative:
-- bind(main_mod .. " + G", hl.dsp.layout("togglesplit"), "Toggle dwindle split")
bind(main_mod .. " + SHIFT + F", hl.dsp.exec_cmd(browser), "Open browser")
bind(main_mod .. " + SHIFT + N", hl.dsp.exec_cmd("/home/sakvi/.config/rofi/notes/notes.sh"), "Open notes")

-- Clipboard manager.
-- bind(main_mod .. " + V", hl.dsp.exec_cmd("cliphist list | wofi --dmenu | cliphist decode | wl-copy"), "Open clipboard history")
-- bind(main_mod .. " + V", hl.dsp.exec_cmd("cliphist list | rofi -dmenu -theme ~/.config/rofi/launcher/style.rasi | cliphist decode | wl-copy"), "Open clipboard history")
bind(
	main_mod .. " + V",
	hl.dsp.exec_cmd(
		"rofi -modi clipboard:~/.config/rofi/clipboard/cliphist-rofi-img.sh -theme ~/.config/rofi/clipboard/style.rasi -show clipboard -show-icons"
	),
	"Open clipboard history"
)
bind(
	main_mod .. " + SHIFT + Y",
	hl.dsp.exec_cmd("/home/sakvi/gatech/archive/fall25/CS2200/Software/CircuitSim1.11.0"),
	"Open CircuitSim"
)

-- Original direct Vim-style bindings (disabled). The active callbacks below
-- preserve the same keys while adapting to scrolling and dwindle layouts.
-- bind(main_mod .. " + H", hl.dsp.focus({ direction = "l" }), "Focus left")
-- bind(main_mod .. " + J", hl.dsp.focus({ direction = "d" }), "Focus down")
-- bind(main_mod .. " + K", hl.dsp.focus({ direction = "u" }), "Focus up")
-- bind(main_mod .. " + L", hl.dsp.focus({ direction = "r" }), "Focus right")
-- bind(main_mod .. " + SHIFT + H", hl.dsp.window.swap({ direction = "l" }), "Swap left")
-- bind(main_mod .. " + SHIFT + J", hl.dsp.window.swap({ direction = "d" }), "Swap down")
-- bind(main_mod .. " + SHIFT + K", hl.dsp.window.swap({ direction = "u" }), "Swap up")
-- bind(main_mod .. " + SHIFT + L", hl.dsp.window.swap({ direction = "r" }), "Swap right")
-- bind(main_mod .. " + SHIFT + CTRL + L", function() relative_resize(0.33, 0) end, "Grow width")
-- bind(main_mod .. " + SHIFT + CTRL + H", function() relative_resize(-0.33, 0) end, "Shrink width")
-- bind(main_mod .. " + SHIFT + CTRL + K", function() relative_resize(0, -0.33) end, "Shrink height")
-- bind(main_mod .. " + SHIFT + CTRL + J", function() relative_resize(0, 0.33) end, "Grow height")

-- Focus.
for key, direction in pairs({ H = "l", J = "d", K = "u", L = "r" }) do
	local target_direction = direction
	bind(main_mod .. " + " .. key, function()
		smart_focus(target_direction)
	end, "Focus " .. target_direction)
end

-- Swapping.
for key, direction in pairs({ H = "l", J = "d", K = "u", L = "r" }) do
	local target_direction = direction
	bind(main_mod .. " + SHIFT + " .. key, function()
		smart_swap(target_direction)
	end, "Swap window " .. target_direction)
end

-- Resizing.
for key, direction in pairs({ L = "l", H = "h", K = "k", J = "j" }) do
	local target_direction = direction
	bind(main_mod .. " + SHIFT + CTRL + " .. key, function()
		smart_resize(target_direction)
	end, "Resize window " .. target_direction, { repeating = true })
end

-- Old workspace implementation.
-- Switch workspaces with mainMod + [0-9].
for workspace = 1, 10 do
	local key = workspace % 10
	bind(main_mod .. " + " .. key, hl.dsp.focus({ workspace = workspace }), "Focus workspace " .. workspace)
end

-- Move the active window silently with mainMod+Shift+[0-9].
for workspace = 1, 10 do
	local key = workspace % 10
	bind(
		main_mod .. " + SHIFT + " .. key,
		hl.dsp.window.move({ workspace = workspace, follow = false }),
		"Move window silently to workspace " .. workspace
	)
end

-- Move the active window and follow it with mainMod+Shift+Control+[0-9].
-- This variant is intentionally not silent.
for workspace = 1, 10 do
	local key = workspace % 10
	bind(
		main_mod .. " + SHIFT + CTRL + " .. key,
		hl.dsp.window.move({ workspace = workspace, follow = true }),
		"Move window to workspace " .. workspace
	)
end

-- Example special workspaces (scratchpads).
bind(main_mod .. " + S", hl.dsp.workspace.toggle_special("magic"), "Toggle magic workspace")
bind(
	main_mod .. " + SHIFT + S",
	hl.dsp.window.move({ workspace = "special:magic", follow = true }),
	"Move window to magic workspace"
)
bind(main_mod .. " + semicolon", hl.dsp.workspace.toggle_special("term"), "Toggle terminal workspace")
bind(
	main_mod .. " + SHIFT + semicolon",
	hl.dsp.window.move({ workspace = "special:term", follow = true }),
	"Move window to terminal workspace"
)

-- Scroll through existing workspaces with mainMod + the scroll wheel.
bind(main_mod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }), "Focus next existing workspace")
bind(main_mod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }), "Focus previous existing workspace")

-- Move/resize windows with mainMod + LMB/RMB and dragging.
bind(main_mod .. " + mouse:272", hl.dsp.window.drag(), "Move window", { mouse = true })
bind(main_mod .. " + mouse:273", hl.dsp.window.resize(), "Resize window", { mouse = true })

-- Laptop multimedia keys for volume and LCD brightness.
local media_flags = { locked = true, repeating = true }
bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"), "Raise volume", media_flags)
bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), "Lower volume", media_flags)
bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), "Toggle output mute", media_flags)
bind(
	"XF86AudioMicMute",
	hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),
	"Toggle microphone mute",
	media_flags
)
bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl s 10%+"), "Raise display brightness", media_flags)
bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl s 10%-"), "Lower display brightness", media_flags)

-- Laptop keyboard light keys.
bind("XF86KbdBrightnessDown", hl.dsp.exec_cmd("asusctl leds set off"), "Turn keyboard light off", media_flags)
bind("XF86KbdBrightnessUp", hl.dsp.exec_cmd("asusctl leds set low"), "Set keyboard light low", media_flags)

-- Requires playerctl.
local locked = { locked = true }
bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), "Next track", locked)
bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), "Toggle playback", locked)
bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), "Toggle playback", locked)
bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), "Previous track", locked)

-- Screenshot with mainMod+Control+Shift+S.
-- Alternative using grimblast:
-- bind(main_mod .. " + SHIFT + CTRL + S", hl.dsp.exec_cmd("grimblast copy area"), "Capture region")
bind(
	main_mod .. " + SHIFT + CTRL + S",
	hl.dsp.exec_cmd("hyprshot -m region -o ~/Pictures/Screenshots"),
	"Capture region"
)

-- OCR recognition.
bind(
	main_mod .. " + SHIFT + CTRL + A",
	hl.dsp.exec_cmd([[grim -g "$(slurp)" - | tesseract - - -l eng | wl-copy]]),
	"Copy region OCR"
)

-- Emoji picker.
bind(main_mod .. " + SHIFT + E", hl.dsp.exec_cmd("~/.config/rofi/emoji/emoji.sh"), "Open emoji picker")

-- Wayscriber (draw on monitor).
bind(main_mod .. " + SHIFT + CTRL + D", hl.dsp.exec_cmd("pkill -SIGUSR1 wayscriber"), "Toggle Wayscriber")

-- Window switch: focus, move, and close.
bind(main_mod .. " + C", hl.dsp.exec_cmd("~/.config/rofi/window-switch/window-switch.pl -f"), "Focus a window")
bind(main_mod .. " + SHIFT + C", hl.dsp.exec_cmd("~/.config/rofi/window-switch/window-switch.pl -m"), "Move a window")
bind(main_mod .. " + SHIFT + W", hl.dsp.exec_cmd("~/.config/rofi/window-switch/window-switch.pl -c"), "Close a window")

-- Scrolling layout controls.
-- Swap columns around.
bind(main_mod .. " + SHIFT + period", hl.dsp.layout("swapcol r"), "Swap column right")
bind(main_mod .. " + SHIFT + comma", hl.dsp.layout("swapcol l"), "Swap column left")

-- Resize the current column.
bind(main_mod .. " + period", hl.dsp.layout("colresize +conf"), "Grow column")
bind(main_mod .. " + comma", hl.dsp.layout("colresize -conf"), "Shrink column")

-- Promote the active window.
bind(main_mod .. " + P", hl.dsp.layout("promote"), "Promote window to column")

-- Scrolling equivalents of togglesplit.
bind(main_mod .. " + G", function()
	move_twice("l", "d")
end, "Move window left then down")
bind(main_mod .. " + SHIFT + G", function()
	move_twice("u", "r")
end, "Move window up then right")

-- Toggle how columns fit on screen.
bind(main_mod .. " + Q", hl.dsp.layout("fit visible"), "Fit visible columns")
bind(main_mod .. " + SHIFT + Q", hl.dsp.layout("fit all"), "Fit all columns")

-- Toggle the global layout. This is the native Lua replacement for
-- scripts/toggle_layout.sh and retains the original notification behavior.
bind(main_mod .. " + SHIFT + A", toggle_layout, "Toggle scrolling and dwindle layouts")

-- Quickshell (requires the corresponding Quickshell configurations).
bind(main_mod .. " + Tab", hl.dsp.exec_cmd("qs ipc -c overview call overview toggle"), "Toggle overview")
bind(
	main_mod .. " + SHIFT + Tab",
	hl.dsp.exec_cmd("quickshell ipc -c qs-hyprview call expose open smartgrid"),
	"Open workspace expose"
)
-- Alternate qs-hyprview actions retained from the original configuration:
-- bind(main_mod .. " + Tab", hl.dsp.exec_cmd("quickshell ipc -c qs-hyprview call expose toggle smartgrid"), "Toggle workspace expose")
-- bind(main_mod .. " + Tab", hl.dsp.exec_cmd("quickshell ipc -c qs-hyprview call expose close"), "Close workspace expose")
bind(main_mod .. " + SHIFT + T", hl.dsp.exec_cmd("quickshell -c QuickSnip -n"), "Open QuickSnip")
