---------------------
--- API / SECRETS ---
---------------------

-- Keep secrets out of executable Lua and version control. This loader accepts
-- the original env = NAME,value format from conf/.api.conf and lets an already
-- exported environment variable override the corresponding private-file value.
local config_root = (os.getenv("HOME") or "/home/sakvi") .. "/.config/hypr"
local private_file = config_root .. "/conf/private.env"

local file = io.open(private_file, "r")
if not file then
    return
end

for line in file:lines() do
    local name, value = line:match("^%s*env%s*=%s*([%w_]+),%s*(.-)%s*$")
    if name and value then
        value = value:gsub('^"(.*)"$', "%1")
        value = value:gsub("^'(.*)'$", "%1")
        hl.env(name, os.getenv(name) or value)
    end
end

file:close()
