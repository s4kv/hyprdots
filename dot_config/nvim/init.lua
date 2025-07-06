-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

-- config for transparent.nvim: this prevents bufferline not being transparent
require("transparent").clear_prefix("BufferLine")
require("transparent").clear_prefix("TabLine")
require("transparent").clear_prefix("WildMenu")
