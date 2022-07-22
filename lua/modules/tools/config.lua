local config = {}

local function load_env_file()
  local env_file = os.getenv("HOME")..'/.env'
  local env_contents = {}
  if vim.fn.filereadable(env_file) ~= 1 then
    print('.env file does not exist')
    return
  end
  local contents = vim.fn.readfile(env_file)
  for _,item in pairs(contents) do
    local line_content = vim.fn.split(item,"=")
    env_contents[line_content[1]] = line_content[2]
  end
  return env_contents
end

local function load_dbs()
  local env_contents = load_env_file()
  local dbs = {}
  for key,value in pairs(env_contents) do
    if vim.fn.stridx(key,"DB_CONNECTION_") >= 0 then
      local db_name = vim.fn.split(key,"_")[3]:lower()
      dbs[db_name] = value
    end
  end
  return dbs
end
-- DB_CONNECTION_db_name=value.
-- https://github.com/kristijanhusak/vim-dadbod-ui
function config.vim_dadbod_ui()
  if packer_plugins['vim-dadbod'] and not packer_plugins['vim-dadbod'].loaded then
    vim.cmd [[packadd vim-dadbod]]
  end
  vim.g.db_ui_show_help = 0
  vim.g.db_ui_win_position = 'left'
  vim.g.db_ui_use_nerd_fonts = 1
  vim.g.db_ui_winwidth = 35
-- why get nil value?
--   vim.g.db_ui_save_location = os.getenv("HOME") .. '/.cache/vim/db_ui_queries'
--   TODO 
  vim.g.db_ui_save_location = '/root/.cache/vim/db_ui_queries'
  vim.g.dbs = load_dbs()
end

-- ctags/lsp symbom view and finder
function config.vim_vista()
  vim.g['vista#renderer#enable_icon'] = 1
  vim.g.vista_disable_statusline = 1
--   vim.g.vista_default_executive = 'nvim_lsp'
  vim.g.vista_default_executive = 'ctags'
  vim.g.vista_echo_cursor_strategy = 'floating_win'
  vim.g.vista_vimwiki_executive = 'markdown'
  vim.g.vista_executive_for = {
    vimwiki =  'markdown',
    pandoc = 'markdown',
    markdown = 'toc',
    typescript = 'nvim_lsp',
    typescriptreact =  'nvim_lsp',
    rust = 'nvim_lsp',
--     c = 'nvim_lsp',
--     cpp = 'nvim_lsp',
  }
end

function config.which_key()
  require('which-key').setup {
  }
end

function config.nvim_dap()
--    local dap = require"dap"
--    dap.configurations.lua = { 
--      { 
--        type = 'nlua', 
--        request = 'attach',
--        name = "Attach to running Neovim instance",
--        host = function()
--          local value = vim.fn.input('Host [127.0.0.1]: ')
--          if value ~= "" then
--            return value
--          end
--          return '127.0.0.1'
--        end,
--  --       port = 8089,
--        port = function()
--          local val = tonumber(vim.fn.input('Port: '))
--          assert(val, "Please provide a port number")
--          return val
--        end,
--      }
--    }
--  
--    dap.adapters.nlua = function(callback, config)
--  --     callback({ type = 'server', host = config.host, port = config.port })
--      callback({ type = 'server', host = config.host or "127.0.0.1", port = config.port or 8089 })
--  
--    end

----------------------------------------------------------
-- `one-small-step-for-vimkind` is an adapter for the Neovim
-- lua language. It allows you to debug any lua code running
-- in a Neovim instance.
-----------------------------------------------------------

-- local dap_lua = safe_require('one-small-step-for-vimkind')
-- if not dap_lua then
--     return
-- end

-- if place in the single depend, will load autom, but if reqruieres and opt=
-- ture, will not load .
--
  if packer_plugins['one-small-step-for-vimkind'] and not packer_plugins['one-small-step-for-vimkind'].loaded then
    vim.cmd [[packadd one-small-step-for-vimkind]]
  end

  local dap = require("dap")
  dap.configurations.lua = {
      {
          type = 'nlua',
          request = 'attach',
          name = "Attach to running Neovim instance",
          host = function()
              -- local value = vim.fn.input('Host [127.0.0.1]: ')
              -- if value ~= "" then
              --     return value
              -- end
              return '127.0.0.1'
          end,
          port = function()
--               local val = 54231
--               return val
              local val = tonumber(vim.fn.input('Port: '))
              assert(val, "Please provide a port number")
              return val
          end
      }
  }
  
  dap.adapters.nlua = function(callback, conf)
      callback({
          type = 'server',
          host = conf.host,
          port = conf.port
      })
  end
  
  
  -- local dap = require "dap"
  
  -- dap.configurations.lua = {
  --     {
  --         type = "nlua",
  --         request = "attach",
  --         name = "Attach to running Neovim instance",
  --         host = function() return "127.0.0.1" end,
  --         port = function()
  --             local val = 54231
  --             return val
  --         end
  --     }
  -- }
  
  -- dap.adapters.nlua = function(callback, config)
  --     callback({type = 'server', host = config.host, port = config.port})
  -- end 

-- c/cpp/rust go config, python need?

  -- c/c++/rust debugging
  -- requires the llvm package installed via homebrew
  dap.adapters.lldb = {
    type = 'executable',
    --command = '/opt/homebrew/opt/llvm/bin/lldb-vscode',
    -- linux lldb-vscode
    command = '/usr/bin/lldb',
    name = "lldb"
  }
  
  dap.configurations.cpp = {
    {
      name = "Launch",
      type = "lldb",
      request = "launch",
      program = function()
        return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
      end,
      -- This env from what? vscode
      cwd = '${workspaceFolder}',
      stopOnEntry = false,
      args = {},
      runInTerminal = false,
    },
  }
  
  -- mirror c++ configuration into c and rust
  dap.configurations.c = dap.configurations.cpp
  dap.configurations.rust = dap.configurations.cpp
  
  -- go debugging
  -- requires the delve package installed via  homebrew
  dap.adapters.go = function(callback, config)
      local stdout = vim.loop.new_pipe(false)
      local handle
      local pid_or_err
      local port = 38697
      local opts = {
        stdio = {nil, stdout},
        args = {"dap", "-l", "127.0.0.1:" .. port},
        detached = true
      }
      handle, pid_or_err = vim.loop.spawn("dlv", opts, function(code)
        stdout:close()
        handle:close()
        if code ~= 0 then
          print('dlv exited with code', code)
        end
      end)
      assert(handle, 'Error running dlv: ' .. tostring(pid_or_err))
      stdout:read_start(function(err, chunk)
        assert(not err, err)
        if chunk then
          vim.schedule(function()
            require('dap.repl').append(chunk)
          end)
        end
      end)
      -- Wait for delve to start
      vim.defer_fn(
        function()
          callback({type = "server", host = "127.0.0.1", port = port})
        end,
        250)
    end
  -- https://github.com/go-delve/delve/blob/master/Documentation/usage/dlv_dap.md
  dap.configurations.go = {
      {
        type = "go",
        name = "Debug",
        request = "launch",
        program = "${workspaceFolder}"
      },
      {
        type = "go",
        name = "Debug test", -- configuration for debugging test files
        request = "launch",
        mode = "test",
        program = "${file}"
      },
      -- works with go.mod packages and sub packages 
      {
        type = "go",
        name = "Debug test (go.mod)",
        request = "launch",
        mode = "test",
        program = "./${relativeFileDirname}"
      } 
  }
  -- allow reading a VS Code launch.json file
  require('dap.ext.vscode').load_launchjs()
  
 -- -- dap-ui setup
 --  require("dapui").setup()

end
function config.markdown()
   -- """""""""""""""""""""""""plasticboy/vim-markdown settings"""""""""""""""""""
   -- " Disable header folding
   vim.g.vim_markdown_folding_disabled = 1
   -- 
   -- " Whether to use conceal feature in markdown
   vim.g.vim_markdown_conceal = 1
   -- 
   -- " Disable math tex conceal and syntax highlight
   vim.g.tex_conceal = ''
   vim.g.vim_markdown_math = 0
   -- 
   -- " Support front matter of various format
   -- " for YAML format 
   vim.g.vim_markdown_frontmatter = 1  
   -- " for TOML format   
   vim.g.vim_markdown_toml_frontmatter = 1  
   --  " for JSON format  
   vim.g.vim_markdown_json_frontmatter = 1 
   -- 
   -- " Let the TOC window autofit so that it doesn't take too much space
   vim.g.vim_markdown_toc_autofit = 1
   -- 
   -- """""""""""""""""""""""""markdown-preview settings"""""""""""""""""""
   -- " Only setting this for suitable platforms
   if vim.g.is_win or vim.g.is_mac then
   --   " Do not close the preview tab when switching to other buffers
       vim.g.mkdp_auto_close = 0
   -- 
   --   " Shortcuts to start and stop markdown previewing
   --   nnoremap <silent> <M-m> :<C-U>MarkdownPreview<CR>
   --   nnoremap <silent> <M-S-m> :<C-U>MarkdownPreviewStop<CR>
      vim.api.nvim_set_keymap('n', '<M-m>', '<C-U>MarkdownPreview<CR>', {silent
      = true})
      vim.api.nvim_set_keymap('n', '<M-S-m>', '<C-U>MarkdownPreviewStop<CR>', {silent
      = true})
   end
end

function config.zen_mode()
  require("zen-mode").setup({
  window = {
    backdrop = 0.8, -- shade the backdrop of the Zen window. Set to 1 to keep the same as Normal
    width = 120,
    options = {
      -- signcolumn = "no", -- disable signcolumn
      -- number = false, -- disable number column
      -- relativenumber = false, -- disable relative numbers
      cursorline = false, -- disable cursorline
      cursorcolumn = false, -- disable cursor column
      foldcolumn = "0", -- disable fold column
      list = false, -- disable whitespace characters
    },
  },
})
end


function config.tla()
  if packer_plugins['plenary.nvim'] and not packer_plugins['plenary.nvim'].loaded then
    vim.cmd [[packadd plenary.nvim]]
  end
  -- first need plenary.nvim loaded 
--  require("tla").setup()
  require("tla").setup({
  --   -- Path to java binary directory. $JAVA_HOME by default
    --java_executable = "/usr/lib/jvm/java-11-openjdk/bin",
    -- java_executable = "/usr/lib/jvm/java-11-openjdk/bin/java",
    --java_executable = "/usr/lib/jvm/java-11-openjdk",
   --  -- -- Options passed to the jvm when running tla2tools
   -- --requires = {{'nvim-lua/plenary.nvim',opt = true}}
   -- java_opts = { '-XX:+UseParallelGC' },
   --  -- -- Only needed if you don't wont automatic tla2tools installation
    --tla2tools = "/home/baojg/workspace/tla/tla2tools.jar",
    -- tla2tools = "/home/baojg/workspace/tla/toolbox/tla2tools.jar",
    tla2tools = "/home/baojg/workspace/tla/toolbox/tla2tools.jar",
  })
end
-- -- cache issue lead , so need reset then 
-- ----  require("tla").setup()
-- function config.tla()
--  -- if packer_plugins['one-small-step-for-vimkind'] and not packer_plugins['one-small-step-for-vimkind'].loaded then
--   if packer_plugins['plenary.nvim'] and not packer_plugins['plenary.nvim'].loaded then
--     vim.cmd [[packadd plenary.nvim]]
--   end
--   require("tla").setup()
-- end
-- require("tla").setup({
-- --   -- Path to java binary directory. $JAVA_HOME by default
--  --java_executable = "/usr/lib/jvm/java-11-openjdk/bin",
--  java_executable = "/usr/lib/jvm/java-11-openjdk",
-- --  -- -- Options passed to the jvm when running tla2tools
-- -- --requires = {{'nvim-lua/plenary.nvim',opt = true}}
--  java_opts = { '-XX:+UseParallelGC' },
-- --  -- -- Only needed if you don't wont automatic tla2tools installation
--  tla2tools = "/home/baojg/workspace/tla/tla2tools.jar",
-- })


return config
