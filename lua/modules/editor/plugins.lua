-- local editor = {}
local conf = require('modules.editor.config')

--editor['Raimondi/delimitMate'] = {
--  event = 'InsertEnter',
--  config = conf.delimimate,
--}
--
--editor['rhysd/accelerated-jk'] = {
--  opt = true
--}
--
--editor['norcalli/nvim-colorizer.lua'] = {
--  ft = { 'html','css','sass','vim','typescript','typescriptreact'},
--  config = conf.nvim_colorizer
--}
--
--editor['itchyny/vim-cursorword'] = {
--  event = {'BufReadPre','BufNewFile'},
--  config = conf.vim_cursorwod
--}
--
--editor['hrsh7th/vim-eft'] = {
--  opt = true,
--  config = function()
--    vim.g.eft_ignorecase = true
--  end
--}
--
--editor['kana/vim-operator-replace'] = {
--  keys = {{'x','p'}},
--  config = function()
--    vim.api.nvim_set_keymap("x", "p", "<Plug>(operator-replace)",{silent =true})
--  end,
--  requires = 'kana/vim-operator-user'
--}
--
--editor['rhysd/vim-operator-surround'] = {
--  event = 'BufRead',
--  requires = 'kana/vim-operator-user'
--}
--
--editor['kana/vim-niceblock']  = {
--  opt = true
--}
--
--editor['lervag/vimtex'] = {
--    opt = true,
--    config = conf.vimtex,
--    ft = 'tex'
--}
--
--editor['frabjous/knap'] = {
-- --   opt = true,
-- --   config = conf.knap,
--    -- ft = { 'tex'
--}
--
--
--
--return editor
return {
  {
    "Raimondi/delimitMate",
    event = "InsertEnter",
    config = conf.delimimate,
  },

  {
    "rhysd/accelerated-jk",
    lazy = true, -- opt = true 替换
  },

  {
    "norcalli/nvim-colorizer.lua",
    ft = { "html", "css", "sass", "vim", "typescript", "typescriptreact" },
    config = conf.nvim_colorizer,
  },

  {
    "itchyny/vim-cursorword",
    event = { "BufReadPre", "BufNewFile" },
    config = conf.vim_cursorwod,
  },

  {
    "hrsh7th/vim-eft",
    lazy = true,
    config = function()
      vim.g.eft_ignorecase = true
    end,
  },

  {
    "kana/vim-operator-user",
    lazy = true,
  },

  {
    "kana/vim-operator-replace",
    keys = {
      { "x", "p", "<Plug>(operator-replace)", mode = "x", silent = true },
    },
    dependencies = {
      "kana/vim-operator-user",
    },
  },

  {
    "rhysd/vim-operator-surround",
    event = "BufRead",
    dependencies = {
      "kana/vim-operator-user",
    },
  },

  {
    "kana/vim-niceblock",
    lazy = true,
  },

  {
    "lervag/vimtex",
    ft = "tex",
    config = conf.vimtex,
  },

  {
    "frabjous/knap",
    -- 如果你后续要加配置，请取消注释下面行：
    -- config = conf.knap,
    ft = "tex",
  },
}

