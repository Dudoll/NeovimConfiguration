" use the .vimrc
set runtimepath^=~/.config/nvim/ runtimepath+=~/.config/nvim/after
let &packpath=&runtimepath
" source ~/.config/nvim/.vimrc

set nu

lua require('plugins')

" colorscheme gruvbox
" let g:gruvbox_contrast_dark='hard'

colorscheme catppuccin-mocha " catppuccin-latte, catppuccin-frappe, catppuccin-macchiato, catppuccin-mocha

" plugins
lua require('plugin-config/nvim-tree')
lua require('plugin-config/bufferline')
" lua require('plugin-config/nvim-treesitter')
lua require('plugin-config/lualine')
" below is indent-blankine
lua require('plugin-config/ibl')
" lua require('plugin-config/project')
lua require('plugin-config/toggleterm')
lua require('plugin-config/gitsigns')
lua require('plugin-config/autopair')
lua require('plugin-config/Comment')
lua require('plugin-config/hop')
lua require('plugin-config/surround')
lua require('plugin-config/marks')
lua require('plugin-config/cscope_map')

"   lsp
lua require('lsp/setup')
" 代码补全配置
lua require('lsp/nvim-cmp')
lua require('lsp/ui')
" 直接使用 lspsaga 默认配置
" lua require("lsp/lspsaga")
" lua require("lsp/null-ls")

" set laststatus=0
lua require('plugin-config/which-key')

" basic 设置放在这里的原因是有的插件配置和我们的相冲突，最后以 basic 为准
lua require('basic')
lua require('keybindings')
