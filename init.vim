" 基础设置
lua require('basic')
" 快捷键映射
lua require('keybindings')
" 插件设置
lua require('plugins')

lua require('plugin-config/nvim-tree')
lua require('plugin-config/bufferline')
lua require('plugin-config/treesitter')
lua require('plugin-config/nvim-autopairs')

lua require('lsp/setup')
lua require('lsp/nvim-cmp')

" 皮肤设置
" https://github.com/ellisonleao/gruvbox.nvim
set background=dark
colorscheme zephyr 
