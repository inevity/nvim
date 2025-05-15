local conf = require('modules.ui.config')
-- local ui = {}
-- 
-- --ui['kingedward35/zephyr-nvim'] = {
-- --ui['glepnir/zephyr-nvim'] = {
-- ui['inevity/zephyr-nvim'] = {
--  -- branch = 'main',
--    config = [[vim.cmd('colorscheme zephyr')]],
--    -- requires = {"folke/tokyonight.nvim", opt = true }
--    requires = 'folke/tokyonight.nvim'
-- }
-- -- SrWither/dashboard-nvim
-- ui['glepnir/dashboard-nvim'] = {
--   config = conf.dashboard
-- }
-- 
-- ui['NTBBloodbath/galaxyline.nvim'] = {
-- --ui['glepnir/galaxyline.nvim'] = {
--   branch = 'main',
--   config = conf.galaxyline,
--   -- requires = 'kyazdani42/nvim-web-devicons'
--   --requires = { "kyazdani42/nvim-web-devicons", opt = true }
--   requires = 'kyazdani42/nvim-web-devicons'
-- 
-- }
-- 
-- ui['lukas-reineke/indent-blankline.nvim'] = {
--   event = 'BufRead',
--   branch = 'master',
--   main = "ibl",
--   config = conf.indent_blakline
-- }
-- 
-- 
-- ui['akinsho/nvim-bufferline.lua'] = {
--   config = conf.nvim_bufferline,
--   requires = 'kyazdani42/nvim-web-devicons'
-- }
-- 
-- ui['kyazdani42/nvim-tree.lua'] = {
--   cmd = {'NvimTreeToggle','NvimTreeOpen'},
--   config = conf.nvim_tree,
--   requires = 'kyazdani42/nvim-web-devicons'
-- }
-- 
-- ui['lewis6991/gitsigns.nvim'] = {
--   event = {'BufRead','BufNewFile'},
--   config = conf.gitsigns,
--   requires = {'nvim-lua/plenary.nvim',opt=true}
-- }
-- 
-- return ui

return {
  {
    "inevity/zephyr-nvim",
    config = function()
      vim.cmd("colorscheme zephyr")
    end,
    event = "VeryLazy",
    dependencies = {
      "folke/tokyonight.nvim",
    },
  },

  {
    "glepnir/dashboard-nvim",
    event = "VeryLazy",
    config = conf.dashboard,
  },

 -- {
 --   "NTBBloodbath/galaxyline.nvim",
 --   branch = "main",
 --   config = conf.galaxyline,
 --   event = "VeryLazy",
 --   dependencies = {
 --     "kyazdani42/nvim-web-devicons",
 --   },
 -- },
  {
    'nvim-lualine/lualine.nvim',
    branch = "master",
    event = "VeryLazy",
    config = conf.lualine,
    dependencies = { 'nvim-tree/nvim-web-devicons' }
  },

  {
    "lukas-reineke/indent-blankline.nvim",
    event = "BufReadPre", -- 更推荐 than BufRead
    branch = "master",
    main = "ibl", -- 指定 module (lazy.nvim 支持)
    config = conf.indent_blakline,
  },

  {
    "akinsho/nvim-bufferline.lua",
    config = conf.nvim_bufferline,
    event = "VeryLazy",
    dependencies = {
      "kyazdani42/nvim-web-devicons",
    },
  },

  {
    "kyazdani42/nvim-tree.lua",
    cmd = { "NvimTreeToggle", "NvimTreeOpen" },
    --event = "VeryLazy",
    config = conf.nvim_tree,
    dependencies = {
      "kyazdani42/nvim-web-devicons",
    },
  },

  {
    "lewis6991/gitsigns.nvim",
    -- event = { "BufReadPre", "BufNewFile" },
    event = "VeryLazy",
    config = conf.gitsigns,
    dependencies = {
      { "nvim-lua/plenary.nvim", optional = true },
    },
  },
}

