vim.g.mapleader = ","
vim.g.maplocalleader = ","

local map = vim.api.nvim_set_keymap
local opt = {noremap = true, silent = true}

-- background
local function toggle_background()
    if (background == "light")
    then
        background = "dark"
    else
        background = "light"
    end
    vim.go.background = background
    ini_conf['background']['name'] = background
    inifile.save(ini_conf_path, ini_conf)
end
vim.keymap.set("n", "<leader>q", toggle_background)

map("n", "<C-u>", "9k", opt)
map("n", "<C-d>", "9j", opt)
map("n", "<leader>r", ":set rnu!<cr>", opt)
map("i", "<leader>c", "<esc>ciw", opt)
map("i", "<leader>d", "<esc>diw", opt)
map("i", "<leader>a", "<esc>la", opt)
map("i", "<leader>s", "<esc>S", opt)
map("i", "kj", "<esc>", opt)
map("n", "<c-y>", "mZgg/class<cr>1000yy'Z:delmarks Z<cr>", opt)
-- neq => '!='
map("i", "<leader>e", "!=", opt)
map("i", "<leader>r", "->", opt)

-- 分屏
map("n", "<leader>sv", ":vsp<cr>", opt)
map("n", "<leader>sh", ":sp<cr>", opt)
map("n", "<leader>sc", "<c-w>c", opt)
map("n", "<leader>so", "<c-w>o", opt)

-- 窗口之间跳转
map("n", "<a-h>", "<C-w>h", opt)
map("n", "<a-j>", "<C-w>j", opt)
map("n", "<a-k>", "<C-w>k", opt)
map("n", "<a-l>", "<C-w>l", opt)

-- this is a test ()
-- 窗口比例控制
map("n", "<leader>s>", ":vertical resize +20<CR>", opt)
map("n", "<leader>s<", ":vertical resize -20<CR>", opt)
map("n", "<leader>s=", "<C-w>=", opt)
map("n", "<leader>sj", ":resize +10<CR>",opt)
map("n", "<leader>sk", ":resize -10<CR>",opt)


-- Nvimtree Plugin 左侧的目录树
map("n", "<A-m>", ":NvimTreeToggle<CR>", opt)

-- bufferline Plugin 标签栏
map("n", "<c-h>", "<esc>:BufferLineCyclePrev<cr>", {silent=true})
map("n", "<c-l>", "<esc>:BufferLineCycleNext<cr>", opt)
map("n", "<leader>b", "<esc>:BufferLinePickClose<cr>", {silent=true})


-- telescope Plugin 文件搜索
map("n", "<leader>ff", ":lua require('telescope.builtin').find_files()<cr>", opt)
map("n", "<leader>fg", ":lua require('telescope.builtin').live_grep()<cr>", opt)
map("n", "<leader>fb", ":lua require('telescope.builtin').buffers()<cr>", opt)
map("n", "<leader>fh", ":lua require('telescope.builtin').help_tags()<cr>", opt)

-- vimtex
map("n", "\\ll", ":VimtexCompile<cr>", {noremap=true})
map("n", "\\lv", ":VimtexView<cr>", {noremap=true})

-- hop.vim (快速跳转)
map('n', 'F', "<cmd>lua require'hop'.hint_char1()<cr>", opt)
map('n', 'f', "<cmd>lua require'hop'.hint_char1({current_line_only = true})<cr>", opt)
map('o', 'F', "<cmd>lua require'hop'.hint_char1({inclusive_jump = true})<cr>", opt)
map('o', 'F', "<cmd>lua require'hop'.hint_char1({current_line_only = true, inclusive_jump = true})<cr>", opt)
map('', 't', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, inclusive_jump = false})<cr>", opt)
map('', 'T', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, inclusive_jump = false })<cr>", opt)
map('n', '<leader>e', "<cmd> lua require'hop'.hint_words({ hint_position = require'hop.hint'.HintPosition.END })<cr>", opt)
map('v', '<leader>e', "<cmd> lua require'hop'.hint_words({ hint_position = require'hop.hint'.HintPosition.END })<cr>", opt)
map('o', '<leader>e', "<cmd> lua require'hop'.hint_words({ hint_position = require'hop.hint'.HintPosition.END, inclusive_jump = true })<cr>", opt)


-- lsp 回调函数快捷键设置
local pluginKeys = {}

-- comment Plugin
-- 代码注释插件
-- see ./lua/plugin-config/comment.lua
pluginKeys.comment = {
  -- Normal 模式快捷键
  toggler = {
    line = "gcc", -- 行注释
    block = "gbc", -- 块注释
  },
  -- Visual 模式
  opleader = {
    line = "gc",
    block = "gb",
  },
}
-- ctrl + /
map("n", "<C-_>", "gcc", { noremap = false })
map("v", "<C-_>", "gbc", { noremap = false })

-- toggleterm
-- 自定义 toggleterm 3个不同类型的命令行窗口
-- <leader>ta 浮动
-- <leader>tb 右侧
-- <leader>tc 下方
-- 特殊lazygit 窗口，需要安装lazygit
-- <leader>tg lazygit
pluginKeys.mapToggleTerm = function(toggleterm)
    vim.keymap.set({ "n", "t" }, "<leader>ta", toggleterm.toggleA)
    vim.keymap.set({ "n", "t" }, "<leader>tb", toggleterm.toggleB)
    vim.keymap.set({ "n", "t" }, "<leader>tc", toggleterm.toggleC)
    vim.keymap.set({ "n", "t" }, "<leader>tg", toggleterm.toggleG)
end


-- gitsigns
pluginKeys.gitsigns_on_attach = function(bufnr)
  local gs = package.loaded.gitsigns

  local function map(mode, l, r, opts)
    opts = opts or {}
    opts.buffer = bufnr
    vim.keymap.set(mode, l, r, opts)
  end

  -- Navigation
  map("n", "<leader>gj", function()
    if vim.wo.diff then
      return "]c"
    end
    vim.schedule(function()
      gs.next_hunk()
    end)
    return "<Ignore>"
  end, { expr = true })

  map("n", "<leader>gk", function()
    if vim.wo.diff then
      return "[c"
    end
    vim.schedule(function()
      gs.prev_hunk()
    end)
    return "<Ignore>"
  end, { expr = true })

  map({ "n", "v" }, "<leader>gs", ":Gitsigns stage_hunk<CR>")
  map("n", "<leader>gS", gs.stage_buffer)
  map("n", "<leader>gu", gs.undo_stage_hunk)
  map({ "n", "v" }, "<leader>gr", ":Gitsigns reset_hunk<CR>")
  map("n", "<leader>gR", gs.reset_buffer)
  map("n", "<leader>gp", gs.preview_hunk)
  map("n", "<leader>gb", function()
    gs.blame_line({ full = true })
  end)
  map("n", "<leader>gd", gs.diffthis)
  map("n", "<leader>gD", function()
    gs.diffthis("~")
  end)
  -- toggle
  map("n", "<leader>gtd", gs.toggle_deleted)
  map("n", "<leader>gtb", gs.toggle_current_line_blame)
  -- Text object
  map({ "o", "x" }, "ig", ":<C-U>Gitsigns select_hunk<CR>")
end


-- lsp
pluginKeys.maplsp = function(mapbuf)
  -- rename
  mapbuf('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opt)
  -- code action
  mapbuf('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opt)
  -- go xx
  mapbuf('n', 'gd', ':lua vim.lsp.buf.definition()<CR>', opt)
  mapbuf('n', 'gh', ':lua vim.lsp.buf.hover()<CR>', opt)
  mapbuf('n', 'gD', ':lua vim.lsp.buf.declaration()<CR>', opt)
  mapbuf('n', 'gi', ':lua vim.lsp.buf.implementation()<CR>', opt)
  mapbuf('n', 'gr', ':lua vim.lsp.buf.references()<CR>', opt)
  -- diagnostic
  mapbuf('n', 'go', ':lua vim.diagnostic.open_float()<CR>', opt)
  mapbuf('n', 'gp', ':lua vim.diagnostic.goto_prev()<CR>', opt)
  mapbuf('n', 'gn', ':lua vim.diagnostic.goto_next()<CR>', opt)
  -- mapbuf('n', '<leader>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opt)
  -- leader + =
  mapbuf('n', '<leader>=', ':lua vim.lsp.buf.formatting()<CR>', opt)
  -- mapbuf('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opt)
  -- mapbuf('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opt)
  -- mapbuf('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opt)
  -- mapbuf('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opt)
  -- mapbuf('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opt)
end

-- nvim-cmp 自动补全
pluginKeys.cmp = function(cmp)
  return {
    -- 上一个
    ['<c-p>'] = cmp.mapping.select_prev_item(),
    -- 下一个
    ['<c-n>'] = cmp.mapping.select_next_item(),
    -- 出现补全
    ['<A-.>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
    -- 取消
    ['<A-,>'] = cmp.mapping({
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    }),
    -- 确认
    -- Accept currently selected item. If none selected, `select` first item.
    -- Set `select` to `false` to only confirm explicitly selected items.
    ['<CR>'] = cmp.mapping.confirm({
      select = true ,
      behavior = cmp.ConfirmBehavior.Replace
    }),
    -- ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
    ['<C-u>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
    ['<C-d>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
  }
end
return pluginKeys
