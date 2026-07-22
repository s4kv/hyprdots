-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------

-- Environment variables must be configured before the display server starts.
-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Environment-variables/

-- Core Wayland + NVIDIA.
local environment = {
    GBM_BACKEND = "nvidia-drm",
    __GLX_VENDOR_LIBRARY_NAME = "nvidia",
    AQ_DRM_DEVICES = "/dev/dri/card1",

    -- Session identity.
    XDG_SESSION_TYPE = "wayland",
    XDG_CURRENT_DESKTOP = "Hyprland",
    XDG_SESSION_DESKTOP = "Hyprland",

    -- Toolkits. Prefer Wayland while retaining X11 fallback for older Qt apps.
    QT_QPA_PLATFORM = "wayland;xcb", -- Prefer Wayland; tolerate X11-only Qt apps.
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1",
    QT_QPA_PLATFORMTHEME = "qt5ct",
    -- Electron apps.
    ELECTRON_OZONE_PLATFORM_HINT = "auto",

    -- Cursors.
    XCURSOR_SIZE = "24",
    HYPRCURSOR_SIZE = "24",
    XCURSOR_THEME = "Adwaita",

    -- Android emulation handle; remove if the xcb platform fails.
    ANDROID_EMULATOR_USE_SYSTEM_LIBS = "1",
    SYSTEMD_EDITOR = "nvim",
}

for name, value in pairs(environment) do
    hl.env(name, value)
end

-- Alternative toolkit values retained from the original config:
-- hl.env("QT_QPA_PLATFORM", "wayland;xcb")
-- Avoid forcing SDL globally; set this per game if needed:
-- hl.env("SDL_VIDEODRIVER", "wayland")
-- hl.env("ELECTRON_OZONE_PLATFORM_HINT", "wayland")
-- hl.env("QT_QPA_PLATFORM", "xcb,wayland")

-- Video decode, only when nvidia-vaapi-driver is installed:
-- hl.env("LIBVA_DRIVER_NAME", "nvidia")
-- hl.env("NVD_BACKEND", "direct")

-- Active displays are on the NVIDIA card; keep Hyprland off the disconnected
-- AMD DRM device.

hl.config({
    debug = {
        -- Hyprland now advertises some color-management protocol pieces.
        full_cm_proto = true,
    },
})
