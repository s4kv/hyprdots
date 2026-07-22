---------------
--- PLUGINS ---
---------------

-- This module is intentionally not required by hyprland.lua, matching the
-- commented-out source line in the original entrypoint. Install compatible
-- plugin builds before enabling it; see https://wiki.hypr.land/Plugins/Using-Plugins/.

-- csgo-vulkan-fix
-- Also change CS2's launch command to something like:
--   -vulkan -window -w 1280 -h 960 -vulkan
-- The original configuration used:
--   gamemoderun mangohud %command% -window -w 1280 -h 960 -vulkan
-- Another retained launch-command experiment:
--   SDL_VIDEO_WAYLAND_ALLOW_LIBDECOR=0 __GL_SHADER_DISK_CACHE_SKIP_CLEANUP=1 SDL_VIDEO_MINIMIZE_ON_FOCUS_LOSS=0 gamemoderun %command% -nojoy -high -threads 9 +exec auto
hl.config({
    plugin = {
        csgo_vulkan_fix = {
            res_w = 1280,
            res_h = 960,
            class = "cs2",
            fix_mouse = true,
        },
    },
})

-- Add applications with vkfix_app(initialClass, width, height):
-- hl.plugin.csgo_vulkan_fix.vkfix_app({ app = "cs2", w = 1650, h = 1050 })

-- Hyprexpo.
hl.config({
    plugin = {
        hyprexpo = {
            columns = 3,
            gap_size = 5,
            bg_col = "rgb(111111)",
            -- [center/first] [workspace], for example "first 1" or "center m+1".
            workspace_method = "first 1",
            -- How far the maximum gesture travels.
            gesture_distance = 300,
        },
    },
})

hl.bind("SUPER + N", hl.plugin.hyprexpo.expo("toggle"), {
    description = "Toggle Hyprexpo",
})

-- Tearing experiment for CS2 (disabled):
-- hl.config({ general = { allow_tearing = true } })
-- hl.window_rule({
--     name = "cs2-immediate",
--     match = { class = "^(cs2)$" },
--     immediate = true,
-- })

-- Hyprfocus
-- https://github.com/daxisunder/hyprfocus
--
-- The old repeated plugin beziers are expressed as named Lua curves so that
-- the block can be restored without duplicate table keys.
-- hl.curve("bezIn", { type = "bezier", points = { { 0.5, 0.0 }, { 1.0, 0.5 } } })
-- hl.curve("bezOut", { type = "bezier", points = { { 0.0, 0.5 }, { 0.5, 1.0 } } })
-- hl.curve("overshot", { type = "bezier", points = { { 0.05, 0.9 }, { 0.1, 1.05 } } })
-- hl.curve("smoothOut", { type = "bezier", points = { { 0.36, 0 }, { 0.66, -0.56 } } })
-- hl.curve("smoothIn", { type = "bezier", points = { { 0.25, 1 }, { 0.5, 1 } } })
-- hl.curve("realsmooth", { type = "bezier", points = { { 0.28, 0.29 }, { 0.69, 1.08 } } })
-- hl.curve("easeInOutBack", { type = "bezier", points = { { 0.68, -0.6 }, { 0.32, 1.6 } } })
-- hl.config({
--     plugin = {
--         hyprfocus = {
--             enabled = true,
--             animate_floating = false,
--             animate_workspacechange = false,
--             focus_animation = "flash",
--             -- Flash settings.
--             flash = {
--                 flash_opacity = 0.7,
--                 in_bezier = "bezIn",
--                 in_speed = 0.1,
--                 out_bezier = "bezOut",
--                 out_speed = 1,
--             },
--             -- Shrink settings.
--             shrink = {
--                 shrink_percentage = 0.99,
--                 in_bezier = "easeInOutBack",
--                 in_speed = 1,
--                 out_bezier = "easeInOutBack",
--                 out_speed = 1,
--             },
--         },
--     },
-- })

-- hyprspace overview (disabled).
-- hl.config({
--     plugin = {
--         overview = {
--             disableBlur = true,
--             -- Gap handling.
--             affectStrut = false,
--             -- overrideGaps = 0,
--             exitOnClick = true,
--             onBottom = false,
--         },
--     },
-- })

-- Alternate Hyprexpo setup (disabled).
-- hl.bind("SUPER + SHIFT + grave", hl.plugin.hyprexpo.expo("toggle"), {
--     description = "Toggle Hyprexpo",
-- })
-- The expo action can be "toggle", "select", "off"/"disable", or "on"/"enable".
-- hl.config({
--     plugin = {
--         hyprexpo = {
--             columns = 5,
--             gap_size = 5,
--             bg_col = "rgb(111111)",
--             -- [center/first] [workspace], for example "first 1" or "center m+1".
--             workspace_method = "center current",
--             -- Laptop touchpad gesture settings:
--             -- enable_gesture = true,
--             -- gesture_fingers = 3, -- 3 or 4.
--             -- gesture_distance = 300, -- How far the maximum gesture travels.
--             -- gesture_positive = true, -- Positive swipes down; negative swipes up.
--         },
--     },
-- })

-- Hyprwinwrap (disabled).
-- hl.config({
--     plugin = {
--         hyprwinwrap = {
--             -- Class is an exact match, not a regular expression.
--             class = "kitty-bg",
--         },
--     },
-- })

-- dynamic-cursors (disabled).
-- hl.config({
--     plugin = {
--         dynamic_cursors = {
--             -- Enable the plugin.
--             enabled = true,
--
--             -- Cursor behavior: "tilt", "rotate", "stretch", or "none".
--             mode = "tilt",
--
--             -- Minimum angle difference in degrees before changing shape.
--             -- Smaller values are smoother but cost more with hardware cursors.
--             threshold = 2,
--
--             -- Shape rules can override behavior per cursor shape. This is a
--             -- repeatable plugin keyword in Hyprlang; add Lua entries through
--             -- the plugin API that matches the installed plugin version.
--             -- shaperule = {
--             --     { shape = "shape-name", mode = "tilt", property = "value" },
--             -- },
--
--             -- Settings for mode = "rotate".
--             rotate = {
--                 -- Simulated stick length in pixels; most realistic at cursor size.
--                 length = 20,
--                 -- Clockwise offset in degrees, applied to every shape.
--                 offset = 0.0,
--             },
--
--             -- Settings for mode = "tilt".
--             tilt = {
--                 -- Speed in px/s at which the full 60-degree tilt is reached.
--                 limit = 5000,
--                 -- "linear", "quadratic", or "negative_quadratic".
--                 -- See activation in src/mode/utils.cpp for the calculation.
--                 function = "negative_quadratic",
--                 -- Speed calculation window in milliseconds. Higher values
--                 -- smooth slow motion but add delay.
--                 window = 100,
--             },
--
--             -- Settings for mode = "stretch".
--             stretch = {
--                 -- Speed in px/s at which twice the original length is reached.
--                 limit = 3000,
--                 -- "linear", "quadratic", or "negative_quadratic".
--                 -- See activation in src/mode/utils.cpp for the calculation.
--                 function = "quadratic",
--                 -- Speed calculation window in milliseconds. Higher values
--                 -- smooth slow motion but add delay.
--                 window = 100,
--             },
--
--             -- Shake-to-find magnifies the cursor while it is being shaken.
--             shake = {
--                 enabled = false,
--                 -- Use nearest-neighbor (pixelated) scaling while shaking.
--                 -- This can look unusual when effects are enabled.
--                 nearest = true,
--                 -- Lower values detect a shake sooner.
--                 threshold = 6.0,
--                 -- Magnification at shake start.
--                 base = 4.0,
--                 -- Magnification increase per second while shaking continues.
--                 speed = 4.0,
--                 -- Influence of the current shake intensity on speed.
--                 influence = 0.0,
--                 -- Maximum magnification; values below 1 disable the limit.
--                 limit = 0.0,
--                 -- Milliseconds to stay magnified after shaking ends.
--                 timeout = 2000,
--                 -- Show tilt/rotate/etc. behavior while shaking.
--                 effects = false,
--                 -- Emit IPC events for shake; see the plugin's IPC section.
--                 ipc = false,
--             },
--
--             -- Load a higher-resolution texture with hyprcursor when magnified.
--             hyprcursor = {
--                 -- 0/false: never pixelate; 1/true: pixelate when no high-res
--                 -- image exists; 2: always use pixelated scaling.
--                 nearest = true,
--                 -- Enable dedicated hyprcursor support.
--                 enabled = true,
--                 -- Texture resolution. -1 means normal size * shake.base.
--                 -- Very high resolutions can increase load time and memory use.
--                 resolution = -1,
--                 -- Shape for magnified client-side cursors. "clientside" uses
--                 -- the real shape but leaves it pixelated.
--                 fallback = "clientside",
--             },
--         },
--     },
-- })
