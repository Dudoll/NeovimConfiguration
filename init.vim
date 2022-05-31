" use the .vimrc
set runtimepath^=~/.config/nvim/ runtimepath+=~/.config/nvim/after
let &packpath=&runtimepath
source ~/.config/nvim/.vimrc

set nu
lua require('keybindings')
lua require('basic')
lua require('plugins')

set background=dark
colorscheme gruvbox

" plugins
" lua require('plugin-config/nvim-tree')
lua require('plugin-config/bufferline')
lua require('plugin-config/nvim-treesitter')
lua require('plugin-config/lualine')
lua require('plugin-config/indent-blankline')
lua require('plugin-config/project')
lua require('plugin-config/ts-rainbow')
lua require('plugin-config/toggleterm')
lua require('plugin-config/gitsigns')
lua require('plugin-config/autopair')
lua require('plugin-config/Comment')

"   lsp
lua require('lsp/setup')
" 代码补全配置
lua require('lsp/nvim-cmp')
lua require("lsp/ui")

