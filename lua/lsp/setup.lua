local lsp_installer = require "nvim-lsp-installer"

-- 安装列表
-- https://github.com/williamboman/nvim-lsp-installer#available-lsps
-- { key: 语言 value: 配置文件 }
local servers = {
  sumneko_lua = require "lsp.lua", -- /lua/lsp/lua.lua
  -- 用coc.nvim来完成，原生的lsp不够智能
  clangd = require'lspconfig'.clangd.setup{
    arguments = {
      "--query-driver=/usr/bin/clang++",
      "--background-index",
    },
    on_attach = require('keybindings').maplsp
  },
  -- rust_analyzer = require'lspconfig'.rust_analyzer.setup{},
}

lsp_installer.settings({
  ui = {
    icons = {
      server_installed = "✓",
      server_pending = "➜",
      server_uninstalled = "✗",
    }
  }
})

-- 自动安装 LanguageServers
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
  local opts = servers[server.name]
  -- print(opts)
  if opts then
    opts.on_attach = require('keybindings').maplsp
    opts.flags = {
      debounce_text_changes = 150,
    }
    server:setup(opts)
  end
end)






