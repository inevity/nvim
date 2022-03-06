local tools = {}
local conf = require('modules.tools.config')

tools['kristijanhusak/vim-dadbod-ui'] = {
  cmd = {'DBUIToggle','DBUIAddConnection','DBUI','DBUIFindBuffer','DBUIRenameBuffer'},
  config = conf.vim_dadbod_ui,
  requires = {{'tpope/vim-dadbod',opt = true}}
}

tools['editorconfig/editorconfig-vim'] = {
  ft = { 'go','typescript','javascript','vim','rust','zig','c','cpp' }
}

tools['inevity/prodoc.nvim'] = {
  event = 'BufReadPre'
}

tools['liuchengxu/vista.vim'] = {
  cmd = 'Vista',
  config = conf.vim_vista
}

tools['brooth/far.vim'] = {
  cmd = {'Far','Farp'},
  config = function ()
    vim.g['far#source'] = 'rg'
  end
}

tools['iamcco/markdown-preview.nvim'] = {
  ft = 'markdown',
  config = function ()
    vim.g.mkdp_auto_start = 0
  end
}

tools['folke/which-key.nvim'] = {
  config = conf.which_key
}

-- tools['jbyuki/one-small-step-for-vimkind'] = {
-- }
--

tools['mfussenegger/nvim-dap'] = {
  ft = 'lua',
  config = conf.nvim_dap,
 -- How lazy load option? 
 -- becasue have not config ,if need require, will installed 
--  requires = {{'jbyuki/one-small-step-for-vimkind',opt = true}}
  requires = {{'jbyuki/one-small-step-for-vimkind'}}
}

tools['rcarriga/nvim-dap-ui'] = {
  requires = "nvim-dap",
  after = "nvim-dap",
  config = function()
  	require("dapui").setup()
  end,
}

-- tools[simrat39/rust-tools.nvim'] = {
--   after = "nvim-dap",
--   requires = { "mfussenegger/nvim-dap" },
--   config = function()
--   	require("rust-tools").setup({})
--   end,
-- }    

return tools
