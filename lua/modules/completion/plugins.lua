-- local completion = {}
local conf = require('modules.completion.config')

-- -- Plug 'neovim/nvim-lspconfig'
-- -- opt true
-- completion['neovim/nvim-lspconfig'] = {
--   -- event trigger what?
--   event = 'BufReadPre',
--   config = conf.nvim_lsp,
-- }
-- 
-- -- ?
-- -- -- opt true
-- completion['tami5/lspsaga.nvim'] = {
-- --  branch = 'main',
--  -- branch = 'nvim6.0',
--   cmd = 'Lspsaga',
-- }
-- --
-- -- opt true, but who load it?
-- -- Plug 'hrsh7th/cmp-nvim-lsp'
-- completion['hrsh7th/cmp-nvim-lsp'] = {
--  -- opt = true,
-- }
-- 
-- -- Plug 'hrsh7th/cmp-buffer'
-- -- Plug 'hrsh7th/cmp-path'
-- -- Plug 'hrsh7th/cmp-cmdline'
-- -- opt true, but who load it?
-- completion['hrsh7th/cmp-buffer'] = {
-- --  opt = true,
-- }
-- -- opt true, but who load it?
-- completion['hrsh7th/cmp-path'] = {
--  -- opt = true,
-- }
-- -- opt true, but who load it?
-- completion['hrsh7th/cmp-cmdline'] = {
--   -- opt = true,
-- }
-- 
-- 
-- -- opt true
-- -- Plug 'hrsh7th/nvim-cmp'
-- completion['hrsh7th/nvim-cmp'] = {
--   -- event = 'InsertEnter',
--   --event = 'TextChanged',
--   config = conf.nvim_cmp,
-- }
-- -- completion['hrsh7th/nvim-compe'] = {
-- --   event = 'InsertEnter',
-- --   config = conf.nvim_compe,
-- -- }
-- 
-- 
-- -- " For vsnip users.
-- -- Plug 'hrsh7th/cmp-vsnip'
-- -- Plug 'hrsh7th/vim-vsnip'
-- --
-- -- opt true, but who load it?
-- -- start/cmp-vsnip depend cmp
-- completion['hrsh7th/cmp-vsnip'] = {
-- --  opt = true,
-- --  event = 'InsertCharPre',
-- --  config = conf.vim_vsnip
-- }
-- -- opt true
-- completion['hrsh7th/vim-vsnip'] = {
--  -- event = 'InsertCharPre',
--   config = conf.vim_vsnip
-- }
-- 
-- 
-- -- " For luasnip users.
-- -- " Plug 'L3MON4D3/LuaSnip'
-- -- " Plug 'saadparwaiz1/cmp_luasnip'
-- -- 
-- -- " For ultisnips users.
-- -- " Plug 'SirVer/ultisnips'
-- -- " Plug 'quangnguyen30192/cmp-nvim-ultisnips'
-- -- 
-- -- " For snippy users.
-- -- " Plug 'dcampos/nvim-snippy'
-- -- " Plug 'dcampos/cmp-snippy'
-- 
-- 
-- -- opt true
-- -- Adds extra functionality over rust analyzer
-- -- Plug 'simrat39/rust-tools.nvim'
-- completion['simrat39/rust-tools.nvim'] = {
--   --opt = true,
-- --   ft = 'rust',
-- }
-- 
-- 
-- -- opt true
-- completion['nvim-telescope/telescope.nvim'] = {
--   cmd = 'Telescope',
--   config = conf.telescope,
--   requires = {
--     {'nvim-lua/popup.nvim', opt = true},
--     {'nvim-lua/plenary.nvim',opt = true},
--     {'nvim-telescope/telescope-fzy-native.nvim',opt = true},
--   }
-- }
-- 
-- -- completion['glepnir/smartinput.nvim'] = {
-- --   ft = 'go',
-- --   config = conf.smart_input
-- -- }
-- 
-- completion['mattn/vim-sonictemplate'] = {
--   cmd = 'Template',
--   ft = {'go','typescript','lua','javascript','vim','rust','markdown'},
--   config = conf.vim_sonictemplate,
-- }
-- 
-- completion['mattn/emmet-vim'] = {
--   event = 'InsertEnter',
--   ft = {'html','css','javascript','javascriptreact','vue','typescript','typescriptreact'},
--   config = conf.emmet,
-- }
-- 
-- completion['saecki/crates.nvim'] = {
--   event = { "BufRead Cargo.toml" },
--   config = conf.crates,
--   requires = {
--     -- plenary.nvim need config as requred load 	  
--     {'nvim-lua/plenary.nvim',opt = true},
--   }
-- }
-- 
-- -- remove the assic to print plugin 
-- -- disable not fully clean
-- -- completion['tlaplus-community/tlaplus-nvim-plugin'] = {
-- --   ft = 'tla',
-- --   disable = true,
-- -- }
-- completion['dhananjaylatkar/cscope_maps.nvim'] = {
-- }
-- 
-- completion['stevearc/conform.nvim'] = {
-- }
-- 
-- return completion
return {
  {
    "neovim/nvim-lspconfig",
    event = "BufReadPre",
    config = conf.nvim_lsp,
  },

  {
    "tami5/lspsaga.nvim",
    cmd = "Lspsaga",
    -- branch = "main", -- 如果你需要特定分支，可以加回来
  },

  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    config = conf.nvim_cmp,
  },

  {
    "hrsh7th/cmp-nvim-lsp",
    lazy = true, -- 仅作为 nvim-cmp 的依赖
  },

  {
    "hrsh7th/cmp-buffer",
    lazy = true,
  },

  {
    "hrsh7th/cmp-path",
    lazy = true,
  },

  {
    "hrsh7th/cmp-cmdline",
    lazy = true,
  },

  {
    "hrsh7th/cmp-vsnip",
    lazy = true,
  },

  {
    "hrsh7th/vim-vsnip",
    event = "InsertEnter",
    config = conf.vim_vsnip,
  },

  {
    "simrat39/rust-tools.nvim",
    ft = "rust",
    lazy = true,
  },

  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    config = conf.telescope,
    dependencies = {
      { "nvim-lua/popup.nvim", lazy = true },
      { "nvim-lua/plenary.nvim", lazy = true },
      { "nvim-telescope/telescope-fzy-native.nvim", lazy = true },
    },
  },

  {
    "mattn/vim-sonictemplate",
    cmd = "Template",
    ft = { "go", "typescript", "lua", "javascript", "vim", "rust", "markdown" },
    config = conf.vim_sonictemplate,
  },

  {
    "mattn/emmet-vim",
    event = "InsertEnter",
    ft = {
      "html",
      "css",
      "javascript",
      "javascriptreact",
      "vue",
      "typescript",
      "typescriptreact",
    },
    config = conf.emmet,
  },

  {
    "saecki/crates.nvim",
    event = { "BufRead Cargo.toml" },
    config = conf.crates,
    dependencies = {
      { "nvim-lua/plenary.nvim", lazy = true },
    },
  },

  {
    "dhananjaylatkar/cscope_maps.nvim",
    lazy = true,
  },

  {
    "stevearc/conform.nvim",
    lazy = true,
  },

  -- 示例：若要启用 smartinput 插件
  -- {
  --   "glepnir/smartinput.nvim",
  --   ft = "go",
  --   config = conf.smart_input,
  -- },

  -- 禁用插件的写法
  -- {
  --   "tlaplus-community/tlaplus-nvim-plugin",
  --   enabled = false,
  -- },
}

