-- local lang = {}
local conf = require('modules.lang.config')

-- lang['nvim-treesitter/nvim-treesitter'] = {
--   event = 'BufRead',
--   after = 'telescope.nvim',
--   config = conf.nvim_treesitter,
--   --commit = '668de0951a36ef17016074f1120b6aacbe6c4515',
-- 
-- }
-- 
-- lang['nvim-treesitter/nvim-treesitter-textobjects'] = {
--   after = 'nvim-treesitter',
--   --commit = 'c81382328ad47c154261d1528d7c921acad5eae5',
-- }
-- 
-- return lang
return {
  {
    "nvim-treesitter/nvim-treesitter",
    -- event = "BufRead",
    event = "VeryLazy",
    config = conf.nvim_treesitter,
    -- You can pin to a specific commit if necessary:
    -- commit = "668de0951a36ef17016074f1120b6aacbe6c4515",
    dependencies = {
      {
        "nvim-treesitter/nvim-treesitter-textobjects",
        -- commit = "c81382328ad47c154261d1528d7c921acad5eae5",
        lazy = true, -- Ensure it's lazy-loaded after main treesitter
      },
    },
  },
}

