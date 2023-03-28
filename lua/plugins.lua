--在没有安装packer的电脑上，自动安装packer插件
local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
	fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})	--默认地址
	-- fn.system({'git', 'clone', '--depth', '1', 'https://codechina.csdn.net/mirrors/wbthomason/packer.nvim.git', install_path})	--csdn加速镜像
	vim.cmd 'packadd packer.nvim'
end

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]
return require('packer').startup({
    function()
        use 'wbthomason/packer.nvim'-- Packer can manage itself

        -- theme
        use {
            -- "ellisonleao/gruvbox.nvim",
            "morhetz/gruvbox", 
            requires = {"rktjmp/lush.nvim"}
        }

        -- 目录树
        use {
            'kyazdani42/nvim-tree.lua',
            requires = 'kyazdani42/nvim-web-devicons'
        }

        -- 标签栏
        use {
            'akinsho/bufferline.nvim', 
            requires = 'kyazdani42/nvim-web-devicons'
        }

        -- 语法高亮
        use { 
            'nvim-treesitter/nvim-treesitter',
            run = ':TSUpdate' 
        }
        use("p00f/nvim-ts-rainbow")

        -- 状态栏
        use {
            'nvim-lualine/lualine.nvim',
            requires = { 'kyazdani42/nvim-web-devicons', opt = true }
        }

        -- 文件搜索
        use {
            'nvim-telescope/telescope.nvim',
            requires = { {'nvim-lua/plenary.nvim'} }
        }
        -- telescope extensions
        use("LinArcX/telescope-env.nvim")
        use("nvim-telescope/telescope-ui-select.nvim")

        -- project manage
        -- use ("ahmedkhalf/project.nvim")

        -- tab缩进
        use "lukas-reineke/indent-blankline.nvim"


        -- Comment
        use("numToStr/Comment.nvim")
        -- nvim-autopairs
        use("windwp/nvim-autopairs")

        -- hop 实现快速跳转(重载f, t, /, ?)
        use {
            'phaazon/hop.nvim',
            branch = 'v1', -- optional but strongly recommended
            config = function()
                -- you can configure Hop the way you like here; see :h hop-config
            end
        }

        -- which-key
        use {
          "folke/which-key.nvim",
          -- config = function()
          -- end
        }

        -- 浮动terminal
        use {"akinsho/toggleterm.nvim", config = function()
            require("toggleterm").setup()
            end
        }

        use 'lewis6991/gitsigns.nvim'

        -- surround
        use({
            "kylechui/nvim-surround",
            tag = "*", -- Use for stability; omit to use `main` branch for the latest features
        })

        -- marks
        use "chentoast/marks.nvim"

        -- 实现光标在移动时的动画
        use { 'gen740/SmoothCursor.nvim',
          config = function()
            require('smoothcursor').setup()
          end
        }

        -- 实现在<c-d/u> zz 等 scroll 操作时的动画
        use {
          'declancm/cinnamon.nvim',
          config = function() require('cinnamon').setup() end
        }
        -- use {
            -- 'karb94/neoscroll.nvim', 
            -- config = function()
                -- require('neoscroll').setup()
            -- end
        -- }

        -- -----------------------lsp------------------------
        use({ "williamboman/mason.nvim" })
        use({ "williamboman/mason-lspconfig.nvim" })
        use ({'neovim/nvim-lspconfig'})

        -- 代码自动补全
        use {
            'hrsh7th/nvim-cmp', 
            requires = {
                'hrsh7th/cmp-nvim-lsp', 
                'hrsh7th/cmp-buffer', 
                'hrsh7th/cmp-path',      -- { name = 'path' }
                'hrsh7th/cmp-cmdline',   -- { name = 'cmdline' }
                'hrsh7th/cmp-vsnip',     -- { name = 'vsnip' }
                'hrsh7th/vim-vsnip', 
                "ray-x/cmp-treesitter",
                -- vsnip
                'rafamadriz/friendly-snippets', 
            }
        }
        -- UI 增强
        use("onsails/lspkind-nvim")
        use {
            "glepnir/lspsaga.nvim", 
            -- opt = true,
            branch = "main",
            event = "LspAttach", 
            config = function()
                require("lspsaga").setup({})
            end,
            -- after = {
                -- "neovim/nvim-lspconfig", 
            -- }, 
            requires = {
                {"nvim-tree/nvim-web-devicons"},
                --Please make sure you install markdown and markdown_inline parser
                {"nvim-treesitter/nvim-treesitter"}
            }
        }

        -- 代码格式化
        use("mhartington/formatter.nvim")
        use({ "jose-elias-alvarez/null-ls.nvim", 
            requires = "nvim-lua/plenary.nvim" 
        })

        -- TypeScript 增强
        use({ "jose-elias-alvarez/nvim-lsp-ts-utils", 
            requires = "nvim-lua/plenary.nvim" 
        })
        -- Lua 增强
        use("folke/lua-dev.nvim")
        -- JSON 增强
        use("b0o/schemastore.nvim")

    end,
}) 
