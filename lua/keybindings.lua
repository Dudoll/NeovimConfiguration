-- vim 各种模式的区别
-- https://neovim.io/doc/user/map.html#mapmode-n

vim.g.mapleader = ","
vim.g.maplocalleader = ","

-- local map = vim.api.nvim_set_keymap
local kmap = vim.keymap.set
-- local opt = {noremap = true, silent = true}
local pluginKeys = {}

------- 利用 which-key 实现快捷键 ---------
local wkmap = require("which-key").register
local keymap_sets = {}
local keybinding_funcs = require("config/keybinding_funcs")


keymap_sets.control = {
    ["<c-e>"] = {"%", "surround pair"}, 
    
    -- bufferline Plugin 标签栏
    ["<c-h>"] = {"<cmd>BufferLineCyclePrev<cr>", "prev bufferline"}, 
    ["<c-l>"] = {"<cmd>BufferLineCycleNext<cr>", "next bufferline"}, 
}
wkmap(keymap_sets.control, {mode = {"n", "v"}})

keymap_sets.alt = {
    -- Nvimtree Plugin 左侧的目录树
    ["<a-m>"] = {"<cmd>NvimTreeToggle<cr>", "nvim tree"}, 

    -- windows 之间跳转
    ["<a-h>"] = {"<c-w>h", "left windows"}, 
    ["<a-j>"] = {"<c-w>j", "bottom windows"}, 
    ["<a-k>"] = {"<c-w>k", "up windows"}, 
    ["<a-l>"] = {"<c-w>l", "right windows"}, 
}
wkmap(keymap_sets.alt)

-- normal mode
keymap_sets.normal = {
    H = {"^", "soft row head"}, 
    L = {"$", "row tail"}, 
}
wkmap(keymap_sets.normal)

--------------------- hop (overide f/F/t/T) -----------------------
local hop = require("hop")
local hop_direction = require("hop.hint").HintDirection
keymap_sets.hop = {
    f = {
        function() 
            hop.hint_char1({current_line_only = true}) 
        end, 
        "find char in this line"}, 

    F = {
        function() hop.hint_char1() end, 
        "find char in this buffer"
    }, 

    t = {
        function()
            hop.hint_char1({
                direction = hop_direction.AFTER_CURSOR, 
                current_line_only = true, 
                hint_offset = -1
            })
        end, 
        "find after cursor"
    }, 

    T = {
        function()
            hop.hint_char1({
                direction = hop_direction.BEFORE_CURSOR, 
                current_line_only = true, 
                hint_offset = -1
            })
        end, 
        "find before cursor"
    }, 


    ["<leader>e"] = {
        function()
            hop.hint_words({ 
                -- hint_position = require'hop.hint'.HintPosition.END 
            })
        end, 
        "find"
    }, 
}
wkmap(keymap_sets.hop, {mode = {""}})

-- normal mode with <leader>
keymap_sets.leader_normal =  {
    r = {":set rnu!<cr>", "change rnu"}, 
    q = {keybinding_funcs.toggle_background, "toggle background color"}, 
    b = {"<cmd>BufferLinePickClose<cr>", "close one buffer"}, 

    -- windows
    w = {
        -- 分屏
        name = "windows"
        v = {"<cmd>vsp<cr>", "v split the window"}, 
        h = {"<cmd>sp<cr>", "split the window"}, 
        c = {"<c-w>c", "close the windows"}, 
        o = {"<c-w>o", "only save the current window"}, 

        -- 屏幕 resize
        [">"] = {"<cmd>vertical resize +20<cr>", "vertical resize +20"}, 
        ["<"] = {"<cmd>vertical resize -20<CR>", "vertical resize -20"}, 
        ["="] = {"<c-w>=", ""}, 
        j = {"<cmd>resize +10<CR>", "horizontal resite +10"}, 
        k = {"<cmd>resize -10<CR>", "horizontal resite -10"}, 
    }, 
}
wkmap(keymap_sets.leader_normal, {prefix = "<leader>"})


-- insert mode with <leader>
keymap_sets.leader_insert =  {
    c = {"<esc>ciw", "ciw"},
    d = {"<esc>diw", "diw"},
    a = {"<Right>", "move right"},
    s = {"<esc>S", "delete this row"},
    e = {"=", "="}, 
    r = {"->", "->"},
    n = {"!=", "!="}, 
}
wkmap(keymap_sets.leadedr_insert, {prefix = "<leader>", mode = "i"})

--------------------- vimtex -----------------------------
wkmap( {['\\ll'] = {"<cmd>VimtexCompile<cr>", "tex compile"}}, {noremap = true} )
wkmap( {['\\ll'] = {"<cmd>VimtexView<cr>", "tex view"}}, {noremap = true} )
-- map("n", "\\ll", ":VimtexCompile<cr>", {noremap=true})
-- map("n", "\\lv", ":VimtexView<cr>", {noremap=true})


-- 代码注释
-- ctrl + /
wkmap( {["<c-_>"] = {"gcc", "comment one line"}}, {noremap = false} )
wkmap( {["<c-_>"] = {"gbc", "comment one block"}}, {mode = "v", noremap = false} )

-- nvim-tree
pluginKeys.nvimTree = {
     -- v分屏打开文件
  { key = "v", action = "vsplit" },
  -- h分屏打开文件
  { key = "h", action = "split" },
}

-------------------gitsigns------------------------------
local gs = require("gitsigns")
keymap_sets.gitsigns = {
    g = {
        name = "gitsigns",
        j = {keybinding_funcs.next_diff_in_file, "next diff in this file"}, 
        k = {keybinding_funcs.pre_diff_in_file, "prev diff in this file"}, 
        s = {"<cmd>Gitsigns stage_hunk<cr>", "stage hunk"}, 
        r = {"<cmd>Gitsigns reset_hunk<cr>", "reset hunk"}, 
        S = {gs.stage_buffer, "sgate buffer"}, 
        u = {gs.undo_stage_hunk, "undo stage hunk"}, 
        R = {gs.reset_buffer, "reset buffer"}, 
        p = {gs.preview_hunk, "preview hunk"}, 
        b = {function() gs.blame_line({full = true}) end, "blame"}, 
        d = {gs.diffthis, "diff this"}, 
        D = {function() gs.diffthis("~") end, "diff this ~"}, 
        t = {
            name = "toggle", 
            d = {gs.toggle_deleted, "toggle deleted"}, 
            b = {gs.toggle_current_line_blame, "toggle current line blame"}, 
        }
    }
}
wkmap(keymap_sets.gitsigns, {prefix = "<leader>"})

--------------------------- telescope -----------------------------------
local ts = require("telescope.builtin")
keymap_sets.telescope = {
    f = {
        f = {ts.find_files, "find files"}, 
        g = {ts.live_grep, "live grep"}, 
        b = {ts.buffers, "buffers"}, 
        h = {ts.help_tags, "help tags"}, 
    }, 
}
wkmap(keymap_sets.telescope, {prefix = "<leader>"})


--------------------------- toggle terminal -----------------------------------
local toggleterm_keys = require("toggleterm")
keymap_sets.toggleterm = {
    t = {
        name = "toggle terminal", 
        a = {toggleterm_keys.toggleA, "teminal in front of the windows"}, 
        b = {toggleterm_keys.toggleB, "teminal at the right of the windows"}, 
        c = {toggleterm_keys.toggleC, "teminal at the bottom of the windows"}, 
        g = {toggleterm_keys.toggleG, "lazy git"}, 
    }, 
}
wkmap(keymap_sets.toggleterm, {prefix = "<leader>"})


---------------------------lsp-----------------------------------
keymap_sets.lsp_goto = {
    g = {
        d = {"<cmd>lua vim.lsp.buf.definition()<cr>", "get definition"}, 
        h = {"<cmd>lua vim.lsp.buf.hover()<cr>", "get hover"}, 
        D = {"<cmd>lua vim.lsp.buf.declaration()<cr>", "get delaration"}, 
        i = {"<cmd>lua vim.lsp.buf.implementation()<cr>", "get implementation"}, 
        r = {"<cmd>lua vim.lsp.buf.references()<cr>", "get references"}, 
        o = {"<cmd>lua vim.diagnostic.open_float()<cr>", "diagnostic open float"}, 
        p = {"<cmd>lua vim.diagnostic.goto_prev()<cr>", "diagnostic goto prev"}, 
        n = {"<cmd>lua vim.diagnostic.goto_next()<cr>", "diagnostic goto next"}, 
    }, 
    ["<leader>r"] = {
        n = {"<cmd>lua vim.lsp.buf.rename()<cr>", "rename"}, 
    }, 
    ["<space>ca"] = {
        "<cmd>lua vim.lsp.buf.code_action()<cr>", "code action"
    }, 
    ["<leader>="] = {
        "<cmd>lua vim.lsp.buf.formatting()<cr>", "code formatting"
    }, 
}
wkmap(keymap_sets.lsp_goto)

------------- nvim-cmp 自动补全 --------------------
local cmp = require("cmp")
keymap_sets.cmp = {
    ['<c-p>'] = {cmp.mapping.select_prev_item(), "prev item"},
    ['<c-n>'] = {cmp.mapping.select_next_item(), "next item"}, 
}
wkmap(keymap_sets.cmp, {mode = "i"})

pluginKeys.cmp = function(cmp)
  return {
    ['<CR>'] = cmp.mapping.confirm({
                  select = true ,
                  behavior = cmp.ConfirmBehavior.Replace
                }),
  }
end
------------- nvim-cmp 自动补全 end --------------------

return pluginKeys
