------------------
---- MONITORS ----
------------------

-- This configuration is loaded by hyprland.lua.
-- See https://wiki.hypr.land/Configuring/Basics/Monitors/

-- Previous alternatives:
-- hl.monitor({ output = "eDP-1", mode = "preferred", position = "auto", scale = 1.6 })
-- hl.monitor({ output = "eDP-1", mode = "preferred", position = "auto", scale = 1 })

-- Past display arrangements:
-- hl.monitor({ output = "HDMI-A-1", mode = "1920x1080", position = "0x0", scale = 1 })
-- hl.monitor({ output = "HDMI-A-1", mode = "3840x2160", position = "0x0", scale = 1.875 })
-- hl.monitor({ output = "eDP-1", mode = "2560x1440@240", position = "auto", scale = "auto" })

-- Current display arrangement. The power-saver binding temporarily drops the
-- internal panel to 60 Hz; keeping both modes here avoids duplicating the rest
-- of its monitor configuration in conf/binds.lua.
local laptop_modes = {
	normal = "2560x1440@240.0",
	power_saving = "2560x1440@60.0",
}

local function configure_laptop(mode)
	hl.monitor({
		output = "eDP-1",
		mode = mode,
		position = "1920x0",
		scale = 1.6,
	})
end

configure_laptop(laptop_modes.normal)

-- Disable the laptop display instead:
-- hl.monitor({ output = "eDP-1", disabled = true })

hl.monitor({
	output = "HDMI-A-1",
	mode = "1920x1080@165.0",
	position = "0x0",
	scale = 1.0,
})

hl.monitor({
	output = "",
	mode = "1920x1080",
	position = "auto",
	scale = 1,
})

-- Historical hyprsome workspace assignments. The Lua equivalents are:
-- hl.workspace_rule({ workspace = "1", monitor = "eDP-1" })
-- hl.workspace_rule({ workspace = "11", monitor = "HDMI-A-1" })

return {
	set_laptop_power_saving = function(enabled)
		configure_laptop(enabled and laptop_modes.power_saving or laptop_modes.normal)
	end,
}
