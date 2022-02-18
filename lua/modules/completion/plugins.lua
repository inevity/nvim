local completion = {}
local conf = require('modules.completion.config')

completion['neovim/nvim-lspconfig'] = {
  event = 'BufReadPre',
  config = conf.nvim_lsp,
}

completion['tami5/lspsaga.nvim'] = {
--  branch = 'main',
  branch = 'nvim6.0',
  cmd = 'Lspsaga',
}
-- Plug 'hrsh7th/cmp-nvim-lsp'
completion['hrsh7th/cmp-nvim-lsp'] = {
  opt = true,
}

-- Plug 'hrsh7th/cmp-buffer'
-- Plug 'hrsh7th/cmp-path'
-- Plug 'hrsh7th/cmp-cmdline'
completion['hrsh7th/cmp-buffer'] = {
  opt = true,
}
completion['hrsh7th/cmp-path'] = {
  opt = true,
}
completion['hrsh7th/cmp-cmdline'] = {
  opt = true,
}


completion['hrsh7th/nvim-cmp'] = {
  event = 'InsertEnter',
  --event = 'TextChanged',
  config = conf.nvim_cmp,
}
-- completion['hrsh7th/nvim-compe'] = {
--   event = 'InsertEnter',
--   config = conf.nvim_compe,
-- }


-- " For vsnip users.
-- Plug 'hrsh7th/cmp-vsnip'
-- Plug 'hrsh7th/vim-vsnip'
--
-- start/cmp-vsnip depend cmp
completion['hrsh7th/cmp-vsnip'] = {
  opt = true,
--  event = 'InsertCharPre',
--  config = conf.vim_vsnip
}
completion['hrsh7th/vim-vsnip'] = {
  event = 'InsertCharPre',
  config = conf.vim_vsnip
}


-- " For luasnip users.
-- " Plug 'L3MON4D3/LuaSnip'
-- " Plug 'saadparwaiz1/cmp_luasnip'
-- 
-- " For ultisnips users.
-- " Plug 'SirVer/ultisnips'
-- " Plug 'quangnguyen30192/cmp-nvim-ultisnips'
-- 
-- " For snippy users.
-- " Plug 'dcampos/nvim-snippy'
-- " Plug 'dcampos/cmp-snippy'


-- Adds extra functionality over rust analyzer
-- Plug 'simrat39/rust-tools.nvim'
completion['simrat39/rust-tools.nvim'] = {
  opt = true,
--   ft = 'rust',
}


completion['nvim-telescope/telescope.nvim'] = {
  cmd = 'Telescope',
  config = conf.telescope,
  requires = {
    {'nvim-lua/popup.nvim', opt = true},
    {'nvim-lua/plenary.nvim',opt = true},
    {'nvim-telescope/telescope-fzy-native.nvim',opt = true},
  }
}

completion['glepnir/smartinput.nvim'] = {
  ft = 'go',
  config = conf.smart_input
}

completion['mattn/vim-sonictemplate'] = {
  cmd = 'Template',
  ft = {'go','typescript','lua','javascript','vim','rust','markdown'},
  config = conf.vim_sonictemplate,
}

completion['mattn/emmet-vim'] = {
  event = 'InsertEnter',
  ft = {'html','css','javascript','javascriptreact','vue','typescript','typescriptreact'},
  config = conf.emmet,
}

return completion
