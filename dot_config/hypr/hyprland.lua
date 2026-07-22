-- Hyprland 0.55+ Lua configuration.
-- Each required file is isolated by Hyprland, so one module error does not
-- prevent unrelated modules from loading.

--------------------
---- API / SECRETS --
--------------------

require("conf.private_env")

-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------

require("conf.environment")

------------------
---- MONITORS ----
------------------

-- Manually set monitor configuration.
require("conf.monitors")
-- Generated nwg-displays configuration alternative:
-- require("conf.display_monitors")

-----------------------
---- LOOK AND FEEL ----
-----------------------

-- Colors are loaded by conf/look.lua from the Matugen-generated colors.lua.
require("conf.look")
-- Direct access to the generated palette, when needed elsewhere:
-- local colors = require("conf.colors")

---------------
---- INPUT ----
---------------

require("conf.input")

--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------

require("conf.windows")

---------------------
---- KEYBINDINGS ----
---------------------

require("conf.binds")

-------------------
---- AUTOSTART ----
-------------------

require("conf.autostart")

-----------------
---- PLUGINS ----
-----------------

-- Plugins were disabled in the original entry point. The translated reference
-- is kept alongside the active modules and can be enabled with:
-- require("conf.plugins")

---------------
---- OTHER ----
---------------

-- Better battery: https://wiki.hypr.land/Configuring/Advanced-and-Cool/Performance/
-- Blur and shadows are disabled in conf/look.lua, matching the final overrides
-- from the original hyprland.conf.
-- hl.config({ debug = { vfr = true } })
