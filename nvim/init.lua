vim.o.encoding = 'utf-8'
vim.o.number = true
vim.o.relativenumber = true
vim.o.title = true
vim.o.autoindent = true
vim.o.backup = false
vim.o.hlsearch = true
vim.o.showcmd = true
vim.o.cmdheight = 1
vim.o.laststatus = 2
vim.o.scrolloff = 10
vim.o.sidescrolloff = 10
vim.o.expandtab = true
vim.o.backupskip = '/tmp/*,/private/tmp/*'
-- Neovim specific
vim.o.inccommand = 'split'
vim.o.scrollbind = false
vim.o.ruler = false
vim.o.showmatch = false
vim.o.lazyredraw = true
vim.o.ignorecase = true
vim.o.smarttab = true
vim.o.shiftwidth = 4
vim.o.tabstop = 4
vim.o.autoindent = true
vim.o.smartindent = true
vim.o.wrap = false
vim.o.cursorline = true
vim.o.suffixesadd = '.c,.cpp,.h,.hpp,.hxx,.m,.mm,.php,.py,.rb,.sh,.swift,.yml,.yaml,.rust,.json,.js,.jsx,.ts,.tsx,.css,.md,.es'
vim.o.exrc = true
vim.o.hidden = true

-- Colors
vim.o.background = 'dark'
vim.o.termguicolors = true
vim.o.winblend = 0
vim.o.wildoptions = 'pum'
vim.o.pumblend = 5
vim.cmd('colorscheme onedark')

-- Globals
vim.g.python3_host_prog = '/usr/bin/python3'
vim.g['prettier#autoformat'] = 1
vim.g['prettier#autoformat_require_pragma'] = 0

-- Plugin config
require('plugins')

-- Mappings config
require('mappings')
