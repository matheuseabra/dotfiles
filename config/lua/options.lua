require "nvchad.options"

-- add yours here! yay

local o = vim.o
local opt = vim.opt

o.cursorlineopt = "both"
o.relativenumber = false
o.showtabline = 2
o.pumblend = 0
o.winblend = 0

opt.keymodel:append { "startsel", "stopsel" }
opt.selectmode = "key"
