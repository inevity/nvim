local ui = {}
local conf = require('modules.ui.config')

--ui['kingedward35/zephyr-nvim'] = {
ui['glepnir/zephyr-nvim'] = {
 -- branch = 'main',
  config = [[vim.cmd('colorscheme zephyr')]]
}
-- SrWither/dashboard-nvim
ui['glepnir/dashboard-nvim'] = {
  config = conf.dashboard
}

ui['NTBBloodbath/galaxyline.nvim'] = {
--ui['glepnir/galaxyline.nvim'] = {
  branch = 'main',
  config = conf.galaxyline,
  -- requires = 'kyazdani42/nvim-web-devicons'
  requires = { "kyazdani42/nvim-web-devicons", opt = true }

}

ui['lukas-reineke/indent-blankline.nvim'] = {
  event = 'BufRead',
  branch = 'master',
  config = conf.indent_blakline
}


ui['akinsho/nvim-bufferline.lua'] = {
  config = conf.nvim_bufferline,
  requires = 'kyazdani42/nvim-web-devicons'
}

ui['kyazdani42/nvim-tree.lua'] = {
  cmd = {'NvimTreeToggle','NvimTreeOpen'},
  config = conf.nvim_tree,
  requires = 'kyazdani42/nvim-web-devicons'
}

ui['lewis6991/gitsigns.nvim'] = {
  event = {'BufRead','BufNewFile'},
  config = conf.gitsigns,
  requires = {'nvim-lua/plenary.nvim',opt=true}
}

return ui
