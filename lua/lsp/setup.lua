local lsp_installer = require "nvim-lsp-installer"
-- 安装列表
-- https://github.com/williamboman/nvim-lsp-installer#available-lsps
-- { key: 语言 value: 配置文件 }
local servers = {
    sumneko_lua =   require "lsp.lua", -- /lua/lsp/lua.lua
    ccls        = require "lsp.cpp", -- /lua/lsp/cpp.lua
    prosemd_lsp =   require "lsp.markdown",
    -- ltex        = require "lsp.ltex",
    -- jdtls       = require "lsp.jdtls",
    -- jsonls      =   require "lsp.json",
    -- grammarly   =   require "lsp.grammarly",
    -- clangd      =   require "lsp.cpp",

}

-- 自动安装 Language Servers
for name, _ in pairs(servers) do
    local server_is_found, server = lsp_installer.get_server(name)
    if server_is_found then
        if not server:is_installed() then
            print("Installing " .. name)
            server:install()
        end
    end
end

lsp_installer.on_server_ready(function(server)
    local config = servers[server.name]
    if config == nil then
        return
    end
    if type(config) == "table" and config.on_setup then
        -- 自定义初始化配置文件必须实现on_setup 方法
        config.on_setup(server)
    else
        -- 使用默认参数
        server:setup({})
    end
end)
