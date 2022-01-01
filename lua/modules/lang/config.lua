local config = {}

function config.nvim_treesitter()
  vim.api.nvim_command('set foldmethod=expr')
  vim.api.nvim_command('set foldexpr=nvim_treesitter#foldexpr()')
  require'nvim-treesitter.configs'.setup {
    -- list install	  
    ensure_installed = "maintained",
    -- ensure_installed = { "bash", "c", "make", "cpp", "dart", "go", "gomod", "gowork", "java", "javascript", "jsdoc", "json", "json5", "kotlin", "llvm", "lua", "make" ,"markdown", "perl", "python", "regex", "rst", "rust", "toml", "typescript", "vim", "yaml" },
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
  require("nvim-treesitter.install").prefer_git = true
 -- require("nvim-treesitter.install").command_extra_args = {
 --    curl = { "--proxy", "https://192.168.1.185:1088" },
 -- }
end

return config
