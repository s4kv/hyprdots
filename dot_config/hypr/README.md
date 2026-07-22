# Hyprland Lua configuration

This is the Hyprland 0.55+ Lua configuration installed at
`~/.config/hypr/hyprland.lua`.

## Validate and start

Validate without starting a compositor:

```sh
Hyprland --verify-config --config ~/.config/hypr/hyprland.lua
```

Start it from a TTY or session launcher:

```sh
~/.config/hypr/start.sh
```

To run the matching idle daemon manually:

```sh
hypridle --config ~/.config/hypr/hypridle.conf
```

Hyprland automatically selects `hyprland.lua` from this directory. `start.sh`
passes the path explicitly so it also works from a TTY or session launcher.

## Structure

- `hyprland.lua` loads isolated modules from `conf/` with `require()`.
- `conf/binds.lua` keeps the existing keys but replaces the layout helper shell
  scripts with native Lua callbacks.
- `conf/display_monitors.lua` is the translated, inactive nwg-displays
  alternative to the manually maintained `conf/monitors.lua`.
- `conf/plugins.lua` preserves the original inactive plugin configuration and
  its disabled experiments in Lua form.
- `hypridle.conf`, `hyprlock.conf`, and `hyprpaper.conf` remain Hyprlang because
  the companion tools have not migrated to Lua.
- `~/.config/matugen/config.toml` is the canonical theme pipeline. It sets the
  wallpaper through awww, generates `conf/colors.lua` and the Hyprlock-compatible
  `conf/colors.conf`, then restarts Waybar.
- `matugen.toml` remains available as an optional Hypr-only generation profile.
- `conf/private.env` contains the copied private environment values, is ignored
  by Git, and is restricted to the owner.

The configuration targets the locally installed Hyprland 0.55.4 API and the
stubs at `/usr/share/hypr/stubs`.

## Intentional fixes

- Removed the duplicate DBus activation environment autostart.
- Split the malformed gnome-keyring/ROG autostart into two valid commands.
- Updated the moved CircuitSim target while preserving `SUPER+SHIFT+Y`.
- Replaced obsolete wlroots renderer/cursor environment variables with the
  active Aquamarine and `cursor.no_hardware_cursors` settings.
- Added Qt's documented X11 fallback while keeping Wayland preferred.
- Consolidated final blur/shadow overrides into their actual effective values.
- Preserved configuration comments and translated disabled configuration
  examples to Lua so they can be restored without converting Hyprlang first.

References:

- https://wiki.hypr.land/Configuring/Start/
- https://wiki.hypr.land/Configuring/Basics/Autostart/
- https://wiki.hypr.land/Configuring/Basics/Binds/
- https://wiki.hypr.land/Configuring/Basics/Variables/
- https://wiki.hypr.land/Configuring/Basics/Dispatchers/
- https://wiki.hypr.land/Configuring/Basics/Window-Rules/
- https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/
- https://wiki.hypr.land/Configuring/Advanced-and-Cool/Animations/
- https://wiki.hypr.land/Configuring/Layouts/Scrolling-Layout/
- https://wiki.hypr.land/Plugins/Using-Plugins/
