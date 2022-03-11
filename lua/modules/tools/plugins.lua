local tools = {}
local conf = require('modules.tools.config')
-- allows simple navigation through databases and allows saving queries for later use
tools['kristijanhusak/vim-dadbod-ui'] = {

  cmd = {'DBUIToggle','DBUIAddConnection','DBUI','DBUIFindBuffer','DBUIRenameBuffer'},
  config = conf.vim_dadbod_ui,
  --TODO use pkg manage depends
  -- will in the vim_dadbod_ui load this dep
  requires = {{'tpope/vim-dadbod',opt = true}}
}

-- The EditorConfig Vim plugin supports the following EditorConfig properties
tools['editorconfig/editorconfig-vim'] = {
  ft = { 'go','typescript','javascript','vim','rust','zig','c','cpp' }
}

-- [a neovim comment and annotation plugin using coroutine.](https://github.com/inevity/prodoc.nvim#todo)
tools['inevity/prodoc.nvim'] = {
  event = 'BufReadPre'
}
-- [View and search LSP symbols, tags in Vim/NeoVim.](https://github.com/liuchengxu/vista.vim)
tools['liuchengxu/vista.vim'] = {
  cmd = 'Vista',
  config = conf.vim_vista
}

--[Find And Replace Vim plugi](https://github.com/brooth/far.vim)
tools['brooth/far.vim'] = {
  cmd = {'Far','Farp'},
  config = function ()
    vim.g['far#source'] = 'rg'
  end
}

--preservim/vim-markdown
-- tools['iamcco/markdown-preview.nvim'] = {
--   ft = 'markdown',
--   config = function ()
--     vim.g.mkdp_auto_start = 0
--   end
-- }

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

    -- Another markdown plugin
tools['plasticboy/vim-markdown'] = {
  ft = "markdown",
  requires = {
    {'godlygeek/tabular', cmd = "Tabularize"},
    {'elzr/vim-json', ft = { "json", "markdown" }},
    {'vim-pandoc/vim-markdownfootnotes', ft = "markdown"},
  }
}

   -- Faster footnote generation
-- tools['vim-pandoc/vim-markdownfootnotes'] = {
--   ft = "markdown"
-- }

-- Vim tabular plugin for manipulate tabular, required by markdown plugins
-- tools['godlygeek/tabular'] = {
--   cmd = "Tabularize"
-- }

   -- Markdown JSON header highlight plugin
-- tools['elzr/vim-json'] = {
--   ft = { "json", "markdown" }
-- }

-- " If you don't have nodejs and yarn
-- " use pre build, add 'vim-plug' to the filetype list so vim-plug can update this plugin
-- " see: https://github.com/iamcco/markdown-preview.nvim/issues/50
-- Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
-- " If you have nodejs and yarn
-- Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }


-- Markdown previewing (only for Mac and Windows)
if vim.g.is_win or vim.g.is_mac then
  tools['iamcco/markdown-preview.nvim'] = {
--     run = function()
--       vim.fn["mkdp#util#install"]()
--     end,
-- " If you have nodejs and yarn
    run = "cd app && yarn install",
--     run = [[sh -c 'cd app && yarn install']],
    config = function ()
      vim.g.mkdp_auto_start = 0
    end,
    setup = function() vim.g.mkdp_filetypes = { "markdown" } end,
--     ft = { "markdown" },
    cmd = 'MarkdownPreview',
  }
end

tools['folke/zen-mode.nvim'] = {
  cmd = 'ZenMode',
--   config = ,
  config = conf.zen_mode,
}


return tools
