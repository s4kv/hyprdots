-------------------
---- AUTOSTART ----
-------------------

-- Autostart necessary processes such as applets and notification daemons.
-- See https://wiki.hypr.land/Configuring/Basics/Autostart/.
-- Or execute favorite apps at launch like this inside the start callback:
-- hl.exec_cmd("ghostty")

local config_root = (os.getenv("HOME") or "/home/sakvi") .. "/.config/hypr"

hl.on("hyprland.start", function()
	hl.exec_cmd("nm-applet")
	hl.exec_cmd("blueman-applet")

	-- Started by a systemd user service; do not launch a second ScreenSaver
	-- provider here.
	-- hl.exec_cmd("hypridle --config ~/.config/hypr/hypridle.conf")
	-- hl.exec_cmd("hyprpaper --config ~/.config/hypr/hyprpaper.conf")

	hl.exec_cmd("mako")

	-- Waybar is handled by Matugen.
	-- hl.exec_cmd("waybar")

	hl.exec_cmd("sleep 2; xrdb merge ~/.Xresources")
	-- hl.exec_cmd("swww-daemon; sleep 2; swww img /home/sakvi/Backgrounds/back.jpg")
	hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")

	-- Clipboard manager.
	hl.exec_cmd("wl-paste --type text --watch cliphist store") -- Store only text data.
	hl.exec_cmd("wl-paste --type image --watch cliphist store") -- Store only image data.

	-- ROG Control Center daemon; now a separate valid command below.
	-- hl.exec_cmd("rog-control-center")

	-- XWayland scale alternatives:
	-- hl.exec_cmd("xprop -root -f XWAYLAND_GLOBAL_OUTPUT_SCALE 32c -set XWAYLAND_GLOBAL_OUTPUT_SCALE 2")
	-- hl.exec_cmd("xprop -root -f XWAYLAND_GLOBAL_OUTPUT_SCALE 32c -set XWAYLAND_GLOBAL_OUTPUT_SCALE 1")
	-- hl.exec_cmd("cd ~/.config/fabric; uwsm app -- python main.py")

	-- Plugins.
	hl.exec_cmd("hyprpm reload -n")

	-- Random wallpaper alternative:
	-- hl.exec_cmd(config_root .. "/swww-wall.sh")
	-- Set wallpaper.
	hl.exec_cmd(config_root .. "/boot-wall.sh")

	-- Auto-mount USB devices.
	hl.exec_cmd("udiskie --appindicator -t")

	-- Wayscriber desktop drawing daemon:
	-- hl.exec_cmd("wayscriber --daemon --no-tray")

	hl.exec_cmd("/usr/bin/gnome-keyring-daemon --start --components=secrets")
	hl.exec_cmd("rog-control-center")

	-- QUICKSHELL [needs quickshell config].
	hl.exec_cmd("qs -c overview")
	hl.exec_cmd("qs -c qs-hyprview")

	-- Temporary
	-- hl.exec_cmd("sleep 3; hyprsunset -g 30 -t 4000")
end)
