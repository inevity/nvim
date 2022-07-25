local config = {}

function config.nvim_treesitter()
--  vim.api.nvim_command('set foldmethod=expr')
--  vim.api.nvim_command('set foldexpr=nvim_treesitter#foldexpr()')

  -- vim.opt.foldmethod     = 'expr'
  -- vim.opt.foldexpr       = 'nvim_treesitter#foldexpr()'
  ---WORKAROUND
  vim.api.nvim_create_autocmd({'BufEnter','BufAdd','BufNew','BufNewFile','BufWinEnter'}, {
    group = vim.api.nvim_create_augroup('TS_FOLD_WORKAROUND', {}),
    callback = function()
      vim.opt.foldmethod     = 'expr'
      vim.opt.foldexpr       = 'nvim_treesitter#foldexpr()'
    end
  })
---ENDWORKAROUND
--
  require'nvim-treesitter.configs'.setup {
    -- list install
--     ensure_installed = "maintained",
    -- ensure_installed = { "bash", "c", "make", "cpp", "dart", "go", "gomod", "gowork", "java", "javascript", "jsdoc", "json", "json5", "kotlin", "llvm", "lua", "make" ,"markdown", "perl", "python", "regex", "rst", "rust", "toml", "typescript", "vim", "yaml" },
    ensure_installed = {"bash", "c", "make", "cpp", "lua", "make" ,"markdown", "python", "rust", "tlaplus", "latex"},
    -- Must PackerCompile
    sync_install = false,
    highlight = {
      enable = true,
    },
    -- ignore_install = { "javascript" },
    textobjects = {
      select = {
        enable = true,
        keymaps = {
          ["af"] = "@function.outer",
          ["if"] = "@function.inner",
          ["ac"] = "@class.outer",
          ["ic"] = "@class.inner",
        },
      },
    },
  }
--   require("nvim-treesitter.install").prefer_git = true
    require("nvim-treesitter.install").command_extra_args = {
--           curl = { "--proxy", "https://192.168.1.112:1088" },
          --curl = { "--proxy", "http://192.168.1.188:8080" },
          -- curl = { "--proxy", "http://192.168.1.126:8080" },
    }
    require('nvim-treesitter.install').update({ with_sync = true })
end

return config
