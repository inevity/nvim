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
end

return config
