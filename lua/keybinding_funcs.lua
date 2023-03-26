-- 此文件为 keybindings.lua 中所需要的函数，为了简洁起见，移到这里

local M = {}

-- change background color
M.toggle_background = function()
    if (vim.go.background == "light")
    then
        vim.go.background = "dark"
    else
        vim.go.background = "light"
    end
end


-------------------gitsigns------------------------------
local gs = require("gitsigns")
M.next_diff_in_file = function()
    if vim.wo.diff then
        return "]c"
    end
    vim.schedule(function ()
        gs.next_hunk()
    end)
    return "<Ignore>"
end

M.pre_diff_in_file = function ()
    if vim.wo.diff then
      return "[c"
    end
    vim.schedule(function()
      gs.prev_hunk()
    end)
    return "<Ignore>"
end
-------------------gitsigns------------------------------


return M
