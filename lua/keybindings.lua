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
local wkadd = require("which-key").add
local keymap_sets = {}
local conf_funcs = require("config/funcs")

-- normal mode
keymap_sets.normal = {
	mode = {"n", "v"},
	{"H", "^", desc = "soft row head"},
	{"L", "$", desc = "row tail"},
    {"<c-e>", "%", desc = "surround pair"},
    {"<c-y>", "mZgg9999yy'Z<cmd>delmarks Z<cr>", desc = "copy this file"},

    -- bufferline Plugin 标签栏
    {"<a-h>", "<cmd>BufferLineCyclePrev<cr>", desc = "prev bufferline", group = "bufferline"},
    {"<a-l>", "<cmd>BufferLineCycleNext<cr>", desc = "next bufferline", group = "bufferline"},

    -- Nvimtree Plugin 左侧的目录树
    {"<a-m>", "<cmd>NvimTreeToggle<cr>", desc = "nvim tree"},

    -- windows 之间跳转
    {"<c-h>", "<c-w>h", desc = "left windows"},
    {"<c-j>", "<c-w>j", desc = "bottom windows"},
    {"<c-k>", "<c-w>k", desc = "up windows"},
    {"<c-l>", "<c-w>l", desc = "right windows"},

    {"<c-d>", "5j", desc = "5 lines down"},
    {"<c-u>", "5k", desc = "5 lines up"},
}
wkadd(keymap_sets.normal)

-- insert mode
keymap_sets.insert = {
    mode = {"i"},
    {"<c-d>", "<delete>", desc = "delete"},
    {"<c-f>", "<Right>", desc = "Right"},
    {"<c-b>", "<Left>", desc = "Left"},
    {"<c-a>", "<esc>I", desc = "the head of the line"},
    {"<c-e>", "<esc>A", desc = "the tail of the line"},
    {"kj", "<esc>", desc = "normal mode"},
}
-- wkmap(keymap_sets.insert, {mode = "i"});
wkadd(keymap_sets.insert)

-- normal mode with <leader>
keymap_sets.leader_normal =  {
	mode = {"n"},

	{	
		"<leader>q", 
		conf_funcs.toggle_background(),
		desc = "toggle background color" },

	{ "<leader>b", "<cmd>bd<cr>", desc = "close one buffer" , group = "bufferline"},
	{ "<leader>cb", "<cmd>BufferLinePickClose<cr>", desc = "close one buffer" , group = "bufferline"},

	-- windows
	{ "<leader>w", group = "windows" },
	{ "<leader>w=", "<c-w>=", desc = "", group = "windows"},
	{ "<leader>wc", "<c-w>c", desc = "close the windows", group = "windows" },
	{ "<leader>wh", "<cmd>sp<cr>", desc = "split the window", group = "windows" },
	{ "<leader>wo", "<c-w>o", desc = "only save the current window", group = "windows" },
	{ "<leader>wv", "<cmd>vsp<cr>", desc = "v split the window", group = "windows" },
	{ "<leader>wj", "<cmd>resize +10<CR>", desc = "horizontal resite +10", group = "windows" },
	{ "<leader>wk", "<cmd>resize -10<CR>", desc = "horizontal resite -10", group = "windows" },
	-- 屏幕 resize
	{ "<leader>w<", "<cmd>vertical resize -20<CR>", desc = "vertical resize -20", group = "windows" },
	{ "<leader>w>", "<cmd>vertical resize +20<cr>", desc = "vertical resize +20", group = "windows" },

	{ "<leader>gu", "gUw", desc = "upper the word" },
}
wkadd(keymap_sets.leader_normal)

-- insert mode with <leader>
keymap_sets.leader_insert = {
	mode = { "i" },
	{ "<leader>a", "<Left>", desc = "move left" },
	{ "<leader>d", "<Right>", desc = "move right" },

	{ "<leader>c", "<esc>ciw", desc = "ciw" },
	{ "<leader>s", "<esc>S", desc = "delete this row" },

	{ "<leader>e", "=", desc = "=" },
	{ "<leader>n", "!=", desc = "!=" },
	{ "<leader>r", "->", desc = "->" },
}
wkadd(keymap_sets.leader_insert)
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
	mode = { "n", "o", "v" },
	{	
		"<leader>e", 
        function()
            hop.hint_words({
                -- hint_position = require'hop.hint'.HintPosition.END
            })
        end,
		desc = "find" 
	},
	{	
		"F", 
        function()
            hop.hint_char1({
                current_line_only = true,
                direction = hop_direction.BEFORE_CURSOR,
            })
        end,
		desc = "find char in this line" 
	},
	{
		"T", 
        function()
            hop.hint_char1({
                direction = hop_direction.BEFORE_CURSOR,
                current_line_only = true,
                hint_offset = 1
            })
        end,
		desc = "find before cursor" 
	},
	{	
		"f", 
        function()
            hop.hint_char1({
                current_line_only = true,
                direction = hop_direction.AFTER_CURSOR,
            })
        end,
		desc = "find char in this line" 
	},
	{	
		"t", 
        function()
            hop.hint_char1({
                direction = hop_direction.AFTER_CURSOR,
                current_line_only = true,
                hint_offset = -1
            })
        end,
		desc = "find after cursor" 
	},
}
wkadd(keymap_sets.hop)

--------------------- vimtex -----------------------------
-- wkmap( {
--         ['\\ll'] = {
--             "<cmd>VimtexCompile<cr>",
--             "tex compile"
--         }
--     },
--     {noremap = true}
-- )
-- wkmap( {
--         ['\\ll'] = {
--             "<cmd>VimtexCompile<cr>",
--             "tex compile"
--         },
--         ["\\lv"] = {
--             "<cmd>VimtexView<cr>",
--             "tex view"
--         }
--     },
--     {noremap = true}
-- )

-- 代码注释
-- ctrl + /
wkadd({ "<c-_>", "gcc", desc = "comment one line", remap = true })
wkadd({ "<c-_>", "gbc", desc = "comment one block", mode = "v", remap = true })


-------------------gitsigns------------------------------
local gs = require("gitsigns")
keymap_sets.gitsigns = {
	{ "<leader>g", group = "gitsigns" },
	{ 
		"<leader>gD", 
		gs.preview_hunk,
		desc = "diff this ~" 
	},
	{ 
		"<leader>gR", 
		gs.reset_buffer,
		desc = "reset buffer" 
	},
	{ 
		"<leader>gS",
		gs.stage_buffer,
		desc = "sgate buffer" 
	},
	{ 
		"<leader>gb", 
		function() gs.blame_line({full = true}) end,
		desc = "blame" 
	},
	{ 
		"<leader>gd", 
		gs.diffthis,
		desc = "diff this" 
	},
	{ 
		"<leader>gj", 
		conf_funcs.next_diff_in_file,
		desc = "next diff in this file" 
	},
	{ 
		"<leader>gk", 
		conf_funcs.pre_diff_in_file,
		desc = "prev diff in this file" 
	},
	{ 
		"<leader>gp", 
		gs.preview_hunk,
		desc = "preview hunk" 
	},
	{ 
		"<leader>gr", 
		"<cmd>Gitsigns reset_hunk<cr>", 
		desc = "reset hunk" 
	},
	{ 
		"<leader>gs", 
		"<cmd>Gitsigns stage_hunk<cr>", 
		desc = "stage hunk" 
	},

	{ 
		"<leader>gt", group = "toggle" 
	},
	{ 
		"<leader>gtb", 
		gs.toggle_current_line_blame,
		desc = "toggle current line blame" 
	},
	{ 
		"<leader>gtd", 
		gs.toggle_deleted,
		desc = "toggle deleted" 
	},
	{ 
		"<leader>gu", 
		gs.undo_stage_hunk,
		desc = "undo stage hunk" 
	},
}
wkadd(keymap_sets.gitsigns)

--------------------------- telescope -----------------------------------
local ts = require("telescope.builtin")
keymap_sets.telescope = {
	{ "<leader>f", group = "telescope" },
	{ "<leader>fb", ts.buffers, desc = "buffers" },
	{ "<leader>ff", ts.find_files, desc = "find files" },
	{ "<leader>fg", ts.live_grep, desc = "live grep" },
	{ "<leader>fh", ts.help_tags, desc = "help tags" },
}
wkadd(keymap_sets.telescope)

--------------------------- toggle terminal -----------------------------------
local Terminal  = require('toggleterm.terminal').Terminal
local lazygit = Terminal:new({ cmd = "lazygit", hidden = true, direction = "tab" })

function _lazygit_toggle()
  lazygit:toggle()
end

keymap_sets.toggleterm = {
	{ "<leader>t", group = "toggle terminal" },
	{ "<leader>ta", "<cmd>ToggleTerm direction=float<cr>", desc = "teminal in front of the windows" },
	{ "<leader>tb", "<cmd>ToggleTerm direction=horizontal<cr>", desc = "teminal at the bottom of the windows" },
	{ "<leader>tg", "<cmd>lua _lazygit_toggle()<cr>", desc = "lazygit" },
	{ "<leader>tt", "<cmd>ToggleTerm direction=tab<cr>", desc = "teminal at the tab of the windows" },
	{ "<leader>tv", "<cmd>ToggleTerm direction=vertical<cr>", desc = "teminal at the vertical(right) of the windows" },
}
wkadd(keymap_sets.toggleterm)

---------------------------lsp-----------------------------------
keymap_sets.lsp_goto = {
	{ "<leader>=", "<cmd>lua vim.lsp.buf.formatting()<cr>", desc = "code formatting" },

	{ "<leader>c", group = "code action" },
	{ "<leader>ca", "<cmd>Lspsaga code_action<cr>", desc = "code action" },

	{ "<leader>r", group = "rename" },
	{ "<leader>rr", "<cmd>Lspsaga rename ++project<cr>", desc = "rename the variable" },

	{ "<leader>s", group = "show diagnostic" },
	{ "<leader>sc", "<cmd>Lspsaga show_cursor_diagnostics ++unfocus<cr>", desc = "show cursor diagnostics" },
	{ "<leader>sl", "<cmd>Lspsaga show_line_diagnostics ++unfocus<cr>", desc = "show line diagnostics" },
	{ "<leader>so", "<cmd>Lspsaga outline<cr>", desc = "outline" },

	{ "gd", "<cmd>Lspsaga goto_definition<cr>", desc = "goto definition" },
	{ "gh", "<cmd>Lspsaga hover_doc ++quiet<cr>", desc = "peek hover" },
	{ "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>", desc = "get implementation" },
	{ "gn", "<cmd>Lspsaga diagnostic_jump_next<cr>", desc = "diagnostic goto next" },
	{ "gp", "<cmd>Lspsaga diagnostic_jump_next<cr>", desc = "diagnostic goto prev" },
	{ "gr", "<cmd>Lspsaga finder ref<cr>", desc = "peek reference" },
	{ "gt", "<cmd>Lspsaga goto_type_definition<cr>", desc = "goto type definition" },
}
wkadd(keymap_sets.lsp_goto)

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
