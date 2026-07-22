---------------
---- INPUT ----
---------------

-- https://wiki.hypr.land/Configuring/Basics/Variables/#input
hl.config({
    input = {
        kb_layout = "us",
        kb_variant = "",
        kb_model = "",
        kb_options = "",
        kb_rules = "",

        follow_mouse = 1,
        sensitivity = 0, -- Range: -1.0 to 1.0; zero means no modification.
        accel_profile = "flat",
        numlock_by_default = true,

        touchpad = {
            natural_scroll = true,
            disable_while_typing = false,
        },

        tablet = {
            output = "current",
        },

        -- Middle-click scrolling alternative:
        -- scroll_method = "on_button_down",
        -- scroll_button = 274,
    },
})

-- https://wiki.hypr.land/Configuring/Advanced-and-Cool/Gestures/
hl.gesture({
    fingers = 3,
    direction = "horizontal",
    action = "workspace",
})

-- Example per-device config.
-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Devices/
hl.device({
    name = "epic-mouse-v1",
    sensitivity = -0.5,
})
