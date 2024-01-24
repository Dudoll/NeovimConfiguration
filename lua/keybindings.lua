-- vim 各种模式的区别
-- https://neovim.io/doc/user/map.html#mapmode-n

vim.g.mapleader = ","
vim.g.maplocalleader = ","
-- local map = vim.api.nvim_set_keymap
-- local kmap = vim.keymap.set
-- local opt = {noremap = true, silent = true}
local pluginKeys = {}

------- 利用 which-key 实现快捷键 ---------
local wkmap = require("which-key").register
local keymap_sets = {}
local conf_funcs = require("config/funcs")

-- normal mode
keymap_sets.normal = {
    H = {"^", "soft row head"},
    L = {"$", "row tail"},
    ["<c-e>"] = {"%", "surround pair"},
    ["<c-y>"] = {"mZgg9999yy'Z<cmd>delmarks Z<cr>", "copy this file"},

    -- bufferline Plugin 标签栏
    ["<a-h>"] = {"<cmd>BufferLineCyclePrev<cr>", "prev bufferline"},
    ["<a-l>"] = {"<cmd>BufferLineCycleNext<cr>", "next bufferline"},

    -- Nvimtree Plugin 左侧的目录树
    ["<a-m>"] = {"<cmd>NvimTreeToggle<cr>", "nvim tree"},

    -- windows 之间跳转
    ["<c-h>"] = {"<c-w>h", "left windows"},
    ["<c-j>"] = {"<c-w>j", "bottom windows"},
    ["<c-k>"] = {"<c-w>k", "up windows"},
    ["<c-l>"] = {"<c-w>l", "right windows"},

    ["<c-d>"] = {"5j", "5 lines down"},
    ["<c-u>"] = {"5k", "5 lines up"},
}
wkmap(keymap_sets.normal, {mode = "n"})
wkmap(keymap_sets.normal, {mode = "v"})

-- insert mode
keymap_sets.insert = {
    ["<c-d>"] = {"<delete>", "delete"},
    ["<c-f>"] = {"<Right>", "Right"},
    ["<c-b>"] = {"<Left>", "Left"},
    ["<c-a>"] = {"<esc>I", "the head of the line"},
    ["<c-e>"] = {"<esc>A", "the tail of the line"},
    k = {
        j = {"<esc>", "normal mode"},
    }
}
wkmap(keymap_sets.insert, {mode = "i"});

-- normal mode with <leader>
keymap_sets.leader_normal =  {
    r = {
        n = {":set rnu!<cr>", "change rnu"},
    },
    q = {conf_funcs.toggle_background, "toggle background color"},
    b = {"<cmd>bd<cr>", "close one buffer"},
    c = {
        b = {"<cmd>BufferLinePickClose<cr>", "close one buffer"}
    },
    g = {
        u = {"gUw", "upper the word"},
    },

    -- windows
    w = {
        -- 分屏
        name = "windows",
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
    a = {"<Left>", "move left"},
    d = {"<Right>", "move right"},
    s = {"<esc>S", "delete this row"},
    e = {"=", "="},
    r = {"->", "->"},
    n = {"!=", "!="},
}
wkmap(keymap_sets.leader_insert, {prefix = "<leader>", mode = "i"})

--------------------- cinnamon 平滑 scroll------------------------
-- keymap_sets.cinnamon = {
--     -- zz/zt/zb 平滑 scroll
--     z = {
--       z = {"<Cmd>lua Scroll('zz', 0, 1)<CR>", "center this line"},
--       t = {"<Cmd>lua Scroll('zt', 0, 1)<CR>", "top this line"},
--       b = {"<Cmd>lua Scroll('zb', 0, 1)<CR>", "bottom this line"},
--     },
--
--     -- n/N for search 平滑 scroll
--     -- n = {"<Cmd>lua Scroll('n', 1)<CR>", "next"},
--     -- N = {"<Cmd>lua Scroll('N', 1)<CR>", "prev"},
--
--     k = {"<Cmd>lua Scroll('k', 0, 1)<CR>", "prev line"},
--     j = {"<Cmd>lua Scroll('j', 0, 1)<CR>", "next line"},
-- }
-- wkmap(keymap_sets.cinnamon)


--------------------- hop (overide f/F/t/T) -----------------------
local hop = require("hop")
local hop_direction = require("hop.hint").HintDirection
keymap_sets.hop = {
    f = {
        function()
            hop.hint_char1({
                current_line_only = true,
                direction = hop_direction.AFTER_CURSOR,
            })
        end,
        "find char in this line"},

    F = {
        function()
            hop.hint_char1({
                current_line_only = true,
                direction = hop_direction.BEFORE_CURSOR,
            })
        end,
        "find char in this line"
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
                hint_offset = 1
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
wkmap(keymap_sets.hop, {mode = {"n", "v", "o"}})

--------------------- vimtex -----------------------------
wkmap( {
        ['\\ll'] = {
            "<cmd>VimtexCompile<cr>",
            "tex compile"
        }
    },
    {noremap = true}
)
wkmap( {
        ['\\ll'] = {
            "<cmd>VimtexCompile<cr>",
            "tex compile"
        },
        ["\\lv"] = {
            "<cmd>VimtexView<cr>",
            "tex view"
        }
    },
    {noremap = true}
)

-- 代码注释
-- ctrl + /
wkmap( {["<c-_>"] = {"gcc", "comment one line"}}, {noremap = false} )
wkmap( {["<c-_>"] = {"gbc", "comment one block"}}, {mode = "v", noremap = false} )


-------------------gitsigns------------------------------
local gs = require("gitsigns")
keymap_sets.gitsigns = {
    g = {
        name = "gitsigns",
        j = {
            conf_funcs.next_diff_in_file,
            "next diff in this file"
        },
        k = {
            conf_funcs.pre_diff_in_file,
            "prev diff in this file"
        },
        s = {

            "<cmd>Gitsigns stage_hunk<cr>", "stage hunk"
        },
        r = {

            "<cmd>Gitsigns reset_hunk<cr>", "reset hunk"
        },
        S = {
            gs.stage_buffer,
            "sgate buffer"
        },
        u = {
            gs.undo_stage_hunk,
            "undo stage hunk"
        },
        R = {
            gs.reset_buffer,
            "reset buffer"
        },
        p = {
            gs.preview_hunk,
            "preview hunk"
        },
        b = {function() gs.blame_line({full = true}) end,
            "blame"
        },
        d = {
            gs.diffthis,
            "diff this"
        },
        D = {
            function() gs.diffthis(
                "~") end, "diff this ~"
        },
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
        name = "telescope",
        f = {ts.find_files, "find files"},
        g = {ts.live_grep, "live grep"},
        b = {ts.buffers, "buffers"},
        h = {ts.help_tags, "help tags"},
    },
}
wkmap(keymap_sets.telescope, {prefix = "<leader>"})


--------------------------- toggle terminal -----------------------------------
local Terminal  = require('toggleterm.terminal').Terminal
local lazygit = Terminal:new({ cmd = "lazygit", hidden = true, direction = "tab" })

function _lazygit_toggle()
  lazygit:toggle()
end

keymap_sets.toggleterm = {
    t = {
        name = "toggle terminal",
        a = {"<cmd>ToggleTerm direction=float<cr>", "teminal in front of the windows"},
        b = {"<cmd>ToggleTerm direction=horizontal<cr>", "teminal at the bottom of the windows"},
        v = {"<cmd>ToggleTerm direction=vertical<cr>", "teminal at the vertical(right) of the windows"},
        t = {"<cmd>ToggleTerm direction=tab<cr>", "teminal at the tab of the windows"},
        -- need to download lazygit
        g = {"<cmd>lua _lazygit_toggle()<cr>", "lazygit"},
    },
}
wkmap(keymap_sets.toggleterm, {prefix = "<leader>"})


---------------------------lsp-----------------------------------
keymap_sets.lsp_goto = {
    g = {
        r = {
            "<cmd>Lspsaga finder ref<cr>",
            "peek reference"
        },
        h = {
            "<cmd>Lspsaga hover_doc ++quiet<cr>",
            "peek hover"
        },
        d = {
            "<cmd>Lspsaga goto_definition<cr>",
            "goto definition"
        },
        i = {
            "<cmd>lua vim.lsp.buf.implementation()<cr>",
            "get implementation"
        },
        p = {
            "<cmd>Lspsaga diagnostic_jump_next<cr>",
            "diagnostic goto prev"
        },
        n = {
            "<cmd>Lspsaga diagnostic_jump_next<cr>",
            "diagnostic goto next"
        },
        t = {
            "<cmd>Lspsaga goto_type_definition<cr>",
            "goto type definition"
        },
    },
    ["<leader>"] = {
        s = {
            name = "show diagnostic",
            l = {
                "<cmd>Lspsaga show_line_diagnostics ++unfocus<cr>",
                "show line diagnostics"
            },
            c = {
                "<cmd>Lspsaga show_cursor_diagnostics ++unfocus<cr>",
                "show cursor diagnostics"
            },
            o = {
                "<cmd>Lspsaga outline<cr>", "outline"
            },
        },
        c = {
            name = "code action",
            a = {
                "<cmd>Lspsaga code_action<cr>",
                "code action"
            }
        },
        r = {
            name = "rename / relative number",
            r = {"<cmd>Lspsaga rename ++project<cr>", "rename the variable"},
        },
        ["="] = {
            "<cmd>lua vim.lsp.buf.formatting()<cr>", "code formatting"
        },
    },
}
wkmap(keymap_sets.lsp_goto)

---------------- nvim-tree -------------------------
pluginKeys.nvimTree = {
     -- v分屏打开文件
  { key = "v", action = "vsplit" },
  -- h分屏打开文件
  { key = "h", action = "split" },
}

------------- nvim-cmp 自动补全 --------------------
pluginKeys.cmp = function(cmp)
  return {
    ['<CR>'] = cmp.mapping.confirm({
                  select = true ,
                  behavior = cmp.ConfirmBehavior.Replace
                }),
    ['<c-p>'] = cmp.mapping.select_prev_item(),
    ['<c-n>'] = cmp.mapping.select_next_item(),
  }
end

return pluginKeys
