vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- 保存本地变量
local map = vim.api.nvim_set_keymap
local opt = {noremap = true, silent = true}
local rec = {noremap = false, silent = false}

-- map('模式','按键','映射为XX'
map("i", "jj", "<Esc>", opt)
map("i", "<C-l>", "<Esc>$a", opt)
map("i", "<C-h>", "<Esc>0i", opt)
map("i", "<C-s>", "<Esc>:w<CR>", opt)
map("i", "<C-z>", "<Esc>ui", opt)

map("n", "<C-s>", ":w<CR>", opt)
map("n", ";", "g_", opt)
map("v", ";", "g_", opt)
map("n", "H", "0", opt)
map("v", "H", "0", opt)
map("n", "<Space>", "o<Esc>", opt)
map("n", "<Tab>", "w", opt)

-- 上下移动10行
map("n", "F", "10j", opt)
map("n", "B", "10k", opt)

-- 缩进
map("v", "<", "<gv", opt)
map("v", ">", ">gv", opt)

-- 分屏
map("n", "sv", ":vsp<CR>", opt)
map("n", "sh", ":sp<CR>", opt)
map("n", "sc", "<C-w>c", opt)
map("n", "so", "<C-w>o", opt) -- close others

-- 比例控制（不常用，因为支持鼠标拖拽）
map("n", "s.", ":vertical resize +20<CR>", opt)
map("n", "s,", ":vertical resize -20<CR>", opt)
map("n", "s=", "<C-w>=", opt)
map("n", "sj", ":resize +10<CR>",opt)
map("n", "sk", ":resize -10<CR>",opt)

-- 分屏跳转
map("n", "<A-h>", "<C-w>h", opt)
map("n", "<A-j>", "<C-w>j", opt)
map("n", "<A-k>", "<C-w>k", opt)
map("n", "<A-l>", "<C-w>l", opt)

-- nvimTree
map('n', '<A-m>', ':NvimTreeToggle<CR>', opt)

-- bufferline
map("n", "<C-h>", ":BufferLineCyclePrev<CR>", opt)
map("n", "<C-l>", ":BufferLineCycleNext<CR>", opt)
map("n", "gb", ":BufferLinePick<CR>", opt)
map("n", "gbd", ":BufferLinePickClose<CR>", opt)
-- map("n", "bdh", ":BufferLineCloseLeft<CR>", opt)
-- map("n", "bdl", ":BufferLineCloseRight<CR>", opt) 

map("n", "<leader>1", ":BufferLineGoToBuffer 1<CR>", opt)
map("n", "<leader>2", ":BufferLineGoToBuffer 2<CR>", opt)
map("n", "<leader>3", ":BufferLineGoToBuffer 3<CR>", opt)
map("n", "<leader>4", ":BufferLineGoToBuffer 4<CR>", opt)
map("n", "<leader>5", ":BufferLineGoToBuffer 5<CR>", opt)
map("n", "<leader>6", ":BufferLineGoToBuffer 6<CR>", opt)
map("n", "<leader>7", ":BufferLineGoToBuffer 7<CR>", opt)
map("n", "<leader>8", ":BufferLineGoToBuffer 8<CR>", opt)
map("n", "<leader>9", ":BufferLineGoToBuffer 9<CR>", opt)


local pluginKeys = {}

-- 代码注释插件
-- see ./lua/plugin-config/comment.lua
pluginKeys.comment = {
  -- toggler = {
  --   line = 'gcc',
  --   block = 'gbc',
  -- },
  -- opleader = {
  --   line = 'g<Space>c',
  --   block = 'g<Space>b',
  -- }
}

-- ctrl + /
map("x", "<C-_>", '<ESC><CMD>lua require("Comment.api").toggle_linewise_op(vim.fn.visualmode())<CR>', opt)
map('n', '<C-_>', '<CMD>lua require("Comment.api").toggle_current_linewise()<CR>', opt)
map('i', '<C-_>', '<CMD>lua require("Comment.api").toggle_current_linewise()<CR>', opt)

--lsp 回调函数快捷键设置
pluginKeys.maplsp = function(_, bufnr)
  print("LSP started")
  local function mapbuf(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  -- local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
  --
  -- rename
  mapbuf('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opt)
  -- code action
  mapbuf('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opt)
  -- go xx
  mapbuf('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opt)
  mapbuf('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opt)
  mapbuf('n', 'gh', '<cmd>lua vim.lsp.buf.hover()<CR>', opt)
  mapbuf('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opt)
  mapbuf('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opt)
  mapbuf('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opt)
  mapbuf('n', 'gt', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opt)
  -- diagnostic
  mapbuf('n', 'go', '<cmd>lua vim.diagnostic.open_float()<CR>', opt)
  mapbuf('n', 'gp', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opt)
  mapbuf('n', 'gn', '<cmd>lua vim.diagnostic.goto_next()<CR>', opt)
  -- mapbuf('n', '<leader>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opt)
  -- leader + =
  mapbuf('n', '<leader>=', '<cmd>lua vim.lsp.buf.formatting()<CR>', opt)
  -- mapbuf('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opt)
  -- mapbuf('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opt)
  -- mapbuf('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opt)
end

-- nvim-cmp 自动补全
pluginKeys.cmp = function(cmp)
  return {
    -- 上一个
    ['<C-k>'] = cmp.mapping.select_prev_item(),
    -- 下一个
    ['<C-j>'] = cmp.mapping.select_next_item(),
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














