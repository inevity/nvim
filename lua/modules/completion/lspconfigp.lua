local api = vim.api
local lspconfig = require 'lspconfig'
-- local global = require 'core.global'
local pack = require 'core.pack'
local format = require('modules.completion.format')

vim.lsp.set_log_level("info")

-- if not packer_plugins['lspsaga.nvim'].loaded then
if not pack.is_plugin_loaded('lspsaga.nvim')   then
  -- vim.cmd [[packadd lspsaga.nvim]]
  require("lazy").load({ plugins = { "lspsaga.nvim" } })
end

local saga = require 'lspsaga'
-- saga.init_lsp_saga({
--   debug = true,
--   code_action_icon = '💡',
--   max_preview_lines = 20,
-- })
local lspsaga = require 'lspsaga'
lspsaga.setup { -- defaults ...
  debug = false,
  use_saga_diagnostic_sign = true,
  -- diagnostic sign
  error_sign = "",
  warn_sign = "",
  hint_sign = "",
  infor_sign = "",
  diagnostic_header_icon = "   ",
  -- code action title icon
--   code_action_icon = "  ",
  code_action_icon = '💡',
  code_action_prompt = {
    enable = true,
    sign = true,
    sign_priority = 40,
    virtual_text = true,
  },
  finder_definition_icon = "  ",
  finder_reference_icon = "  ",
  max_preview_lines = 10,
  finder_action_keys = {
    open = "o",
    vsplit = "s",
    split = "i",
    quit = "q",
    scroll_down = "<C-f>",
    scroll_up = "<C-b>",
  },
  code_action_keys = {
    quit = "q",
    exec = "<CR>",
  },
  rename_action_keys = {
    quit = "<C-c>",
    exec = "<CR>",
  },
  definition_preview_icon = "  ",
  border_style = "single",
  rename_prompt_prefix = "➤",
  rename_output_qflist = {
    enable = false,
    auto_open_qflist = false,
  },
  server_filetype_map = {},
  diagnostic_prefix_format = "%d. ",
  diagnostic_message_format = "%m %c",
  highlight_prefix = false,
}


-- if not packer_plugins['cmp-nvim-lsp'].loaded then
if not pack.is_plugin_loaded('cmp-nvim-lsp')   then
  -- vim.cmd [[packadd cmp-nvim-lsp]]
  require("lazy").load({ plugins = { "cmp-nvim-lsp" } })
end

-- local capabilities = vim.lsp.protocol.make_client_capabilities()
-- capabilities.textDocument.completion.completionItem.snippetSupport = true

-- The nvim-cmp almost supports LSP's capabilities so You should advertise it to LSP servers..

-- local capabilities = vim.lsp.protocol.make_client_capabilities()
-- capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)
local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
-- local capabilities = require('cmp_nvim_lsp').default_capabilities()


function _G.reload_lsp()
  vim.lsp.stop_client(vim.lsp.get_active_clients())
  vim.cmd [[edit]]
end

function _G.open_lsp_log()
  local path = vim.lsp.get_log_path()
  vim.cmd("edit " .. path)
end

vim.cmd('command! -nargs=0 LspLog call v:lua.open_lsp_log()')
vim.cmd('command! -nargs=0 LspRestart call v:lua.reload_lsp()')
-- " Set updatetime for CursorHold
-- " 300ms of no cursor movement to trigger CursorHold
-- set updatetime=300
-- "" Show diagnostic popup on cursor hover
-- "autocmd CursorHold * lua vim.lsp.diagnostic.show_line_diagnostics()
-- " Show diagnostic hover after 'updatetime' and don't steal focus
-- autocmd CursorHold * lua vim.lsp.diagnostic.show_line_diagnostics({focusable = false})
-- vim.cmd('autocmd CursorHold * lua vim.diagnostic.show_line_diagnostics({focusable = false})')
-- Maybe here
-- vim.cmd('autocmd CursorHold * lua vim.diagnostic.open_float(nil, {focusable = false, source = 'always'})')

vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    -- Enable underline, use default values
    underline = true,
    -- Enable virtual text, override spacing to 4
    virtual_text = true,
    signs = {
      enable = true,
      priority = 20
    },
    -- Disable a feature
    update_in_insert = false,
})

local enhance_attach = function(client,bufnr)
  if client.server_capabilities.document_formatting then
    format.lsp_before_save()
  end
  api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
end


--   -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
--   require('lspconfig')['<YOUR_LSP_SERVER>'].setup {
--     capabilities = capabilities
--   }

-- gopls
lspconfig.gopls.setup {
  cmd = {"gopls","--remote=auto"},
  on_attach = enhance_attach,
  capabilities = capabilities,
  init_options = {
    usePlaceholders=true,
    completeUnimported=true,
  }
}

-- -- lua config: Done
-- lspconfig.sumneko_lua.setup {
--   --cmd = {
--   --  global.home.."/workstation/lua-language-server/bin/macOS/lua-language-server",
--   --  "-E",
--   --  global.home.."/workstation/lua-language-server/main.lua"
--   --};
--   cmd = {
--     "lua-language-server"
--   };
--   capabilities = capabilities,
--   settings = {
--     Lua = {
--       diagnostics = {
--         enable = true,
--         globals = {"vim","packer_plugins"}
--       },
--       runtime = {version = "LuaJIT"},
--       workspace = {
--         library = vim.list_extend({[vim.fn.expand("$VIMRUNTIME/lua")] = true},{}),
--       },
--     },
--   }
-- }

--lspconfig.sumneko_lua.setup {
lspconfig.lua_ls.setup {
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
      },
      diagnostics = {
        enable = true,
        -- Get the language server to recognize the `vim` global
        -- globals = {'vim', "packer_plugins"},
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
}


-- ts
lspconfig.ts_ls.setup {
  capabilities = capabilities,
  on_attach = function(client)
    client.server_capabilities.document_formatting = false
    enhance_attach(client)
  end
}

-- clangd :Done
lspconfig.clangd.setup {
  cmd = {
    "clangd",
    "--background-index",
   -- "--suggest-missing-includes",
     "--suggest-missing-includes",
    "--clang-tidy",
    "--header-insertion=iwyu",
    "--log=verbose",
    "--pretty"
  },
  capabilities = capabilities,
}
-- rust analyzer :Done
-- lspconfig.rust_analyzer.setup {
  	
--   capabilities = capabilities,
-- }

local on_init = function(client, bufnr)
    -- project-specific settings
    local path = client.workspace_folders[1].name

    local function path_ends_with(ending)
        assert(ending ~= "")
        return path:sub(-#ending) == ending
    end

    if path_ends_with("dev/personal/wasmtime") then
        client.config.settings["rust-analyzer"].cargo.features = { "wasmtime/cranelift" }
        client.config.settings["rust-analyzer"].cargo.extraEnv = { RUSTFLAGS = "--cfg=compiler" }
        client.config.settings["rust-analyzer"].checkOnSave.features = { "wasmtime/cranelift" }
        client.config.settings["rust-analyzer"].checkOnSave.extraEnv = { RUSTFLAGS = "--cfg=compiler" }
    elseif path_ends_with("dev/personal/wasynth") then
        client.config.settings["rust-analyzer"].cargo.features = { "bytes_trace" }
        client.config.settings["rust-analyzer"].checkOnSave.extraEnv = { "bytes_trace" }
    elseif path_ends_with("tokio") then
                --extraArgs = [],
                -- extraEnv = {"RUSTFLAGS="},
                -- cfgs = {}
        --client.config.settings["rust-analyzer"].cargo.features = { "bytes_trace" }
        client.config.settings["rust-analyzer"].cargo.features =  "all"
        client.config.settings["rust-analyzer"].cargo.extraEnv = { RUSTFLAGS = "-Dwarning --cfg tokio_unstable --cfg tokio_taskdump", RUSTDOCFLAGS = "--cfg tokio_unstable --cfg tokio_taskdump" }
       -- client.config.settings["rust-analyzer"].cargo.extraArgs = { "bytes_trace" }
       -- client.config.settings["rust-analyzer"].cargo.cfgs = { "bytes_trace" }
       -- client.config.settings["rust-analyzer"].checkOnSave.extraEnv = { "bytes_trace" }
    elseif path_ends_with("genbu-server") then
        client.config.settings["rust-analyzer"].cargo.features =  {"jemalloc", "headers", "console", "rtmetric", "s3opendal", "kvd_c_runtime", "tnx-perf-optimize", "mdcache"}
        client.config.settings["rust-analyzer"].cargo.noDefaultFeatures = true
      --  client.config.settings["rust-analyzer"].cargo.extraEnv = { RUSTFLAGS = "-Dwarning --cfg tokio_unstable --cfg tokio_taskdump", RUSTDOCFLAGS = "--cfg tokio_unstable --cfg tokio_taskdump" }
        client.config.settings["rust-analyzer"].cargo.extraEnv = { RUSTFLAGS = "--cfg tokio_unstable --cfg tokio_taskdump", RUSTDOCFLAGS = "--cfg tokio_unstable --cfg tokio_taskdump" }
    else
        client.config.settings["rust-analyzer"].cargo.features =  "all"
        client.config.settings["rust-analyzer"].cargo.extraEnv = { RUSTFLAGS = "-Dwarning --cfg tokio_unstable --cfg tokio_taskdump", RUSTDOCFLAGS = "--cfg tokio_unstable --cfg tokio_taskdump" }
    end

    client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
end

local opts = {
    tools = {
        -- hover_with_actions = true,
        runnables = {
            use_telescope = true
        },
        inlay_hints = {
            show_parameter_hints = false,
            parameter_hints_prefix = "",
            other_hints_prefix = "",
            auto = true,
        },
        hover_actions = {

  --        -- the border that is used for the hover window
  --        -- see vim.api.nvim_open_win()
  --        border = {
  --          { "╭", "FloatBorder" },
  --          { "─", "FloatBorder" },
  --          { "╮", "FloatBorder" },
  --          { "│", "FloatBorder" },
  --          { "╯", "FloatBorder" },
  --          { "─", "FloatBorder" },
  --          { "╰", "FloatBorder" },
  --          { "│", "FloatBorder" },
  --        },

          -- whether the hover action window gets automatically focused
          -- default: false
          auto_focus = true,
        },
    },

    -- all the opts to send to nvim-lspconfig
    -- these override the defaults set by rust-tools.nvim
    -- see https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md#rust_analyzer

    server = {
        capabilities = capabilities,
        on_init = on_init,
        -- on_attach is a callback called when the language server attachs to the buffer
        -- on_attach = on_attach,

       -- how pass rt? in the ? 
        on_attach = function(_, bufnr)
           -- Hover actions
           local rt = require("rust-tools")

           -- vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
           vim.keymap.set("n", "K", rt.hover_actions.hover_actions, { buffer = bufnr })
           -- Code action groups
           vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
        end,



        settings = {
            -- to enable rust-analyzer settings visit:
            -- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
            ["rust-analyzer"] = {
                diagnostics = {
                  enable = true,
                },
                -- enable clippy on save
                checkOnSave = {
                    command = "clippy"
                },

                assist = {
                  importGranularity = "module",
                  importEnforceGranularity = true,
                },
                cargo = {
                  loadOutDirsFromCheck = true,
                  --allFeatures = false,
                  noDefaultFeatures = false,
                  --features = ["all"],
                  --runBuildScripts = true,
                  buildScripts = {
                    enable = true,
                  },
                },
                --extraArgs = [],
                -- extraEnv = {"RUSTFLAGS="},
                -- cfgs = {}
                inlayHints = { locationLinks = false },
                procMacro = {
                  enable = true,
                  attributes = true,
                },
--                 checkOnSave = {
--                   command = "clippy",
--                 },
                --experimental = {
                  --procAttrMacros = true,
                --},
                -- https://rustc-dev-guide.rust-lang.org/building/suggested.html
               -- rustc = {
               --     source = "/rust/Cargo.toml",
               -- },

--               "rust-analyzer.checkOnSave.overrideCommand": [
--                   "python3",
--                   "x.py",
--                   "check",
--                   "--json-output"
--               ],
--               "rust-analyzer.rustfmt.overrideCommand": [
--                   "./build/$TARGET_TRIPLE/stage0/bin/rustfmt",
--                   "--edition=2021"
--               ],
--               "editor.formatOnSave": true,
--               "rust-analyzer.cargo.buildScripts.enable": true,
--               "rust-analyzer.cargo.buildScripts.overrideCommand": [
--                   "cargo",
--                   "check",
--                   "-p",
--                   "rustc_driver",
--                   "--message-format=json"
--               ],
--
            }
        }
    },
     -- TODO add debug 
     -- debugging stuff
    dap = {
      adapter = {
        type = "executable",
        command = "lldb-vscode",
        name = "rt_lldb",
      },
    },
}

-- if not packer_plugins['rust-tools.nvim'].loaded then
if not pack.is_plugin_loaded('rust-tools.nvim')   then
   -- vim.cmd [[packadd rust-tools.nvim]]
   require("lazy").load({ plugins = { "rust-tools.nvim" } })
end

-- if set config for rustc-dev.
require('rust-tools').setup(opts)

-- dockerls, bashls, pyright
-- ???
local servers = {
  'dockerls','bashls','pyright'
}

for _,server in ipairs(servers) do
  lspconfig[server].setup {
    capabilities = capabilities,
    on_attach = enhance_attach
  }
end

require'lspconfig'.ansiblels.setup{}

require'lspconfig'.ocamllsp.setup{}

-- require'cscope_maps'.setup({})
--require'cscope_maps'.setup{}
require'cscope_maps'.setup({
  -- maps related defaults
  disable_maps = false, -- "true" disables default keymaps
  skip_input_prompt = false, -- "true" doesn't ask for input
  prefix = "<leader>c", -- prefix to trigger maps

  -- cscope related defaults
  cscope = {
    -- location of cscope db file
    db_file = "./cscope.out", -- DB or table of DBs
                              -- NOTE:
                              --   when table of DBs is provided -
                              --   first DB is "primary" and others are "secondary"
                              --   primary DB is used for build and project_rooter
    -- cscope executable
    exec = "cscope", -- "cscope" or "gtags-cscope"
    -- choose your fav picker
    picker = "quickfix", -- "quickfix", "location", "telescope", "fzf-lua", "mini-pick" or "snacks"
    -- qf_window_size = 5, -- deprecated, replaced by picket_opts below, but still supported for backward compatibility
    -- qf_window_pos = "bottom", -- deprecated, replaced by picket_opts below, but still supported for backward compatibility
    picker_opts = {
      window_size = 5, -- any positive integer
      window_pos = "bottom", -- "bottom", "right", "left" or "top"
    },
    -- "true" does not open picker for single result, just JUMP
    skip_picker_for_single_result = false, -- "false" or "true"
    -- custom script can be used for db build
    db_build_cmd = { script = "default", args = { "-bqkv" } },
    -- statusline indicator, default is cscope executable
    statusline_indicator = nil,
    -- try to locate db_file in parent dir(s)
    project_rooter = {
      enable = false, -- "true" or "false"
      -- change cwd to where db_file is located
      change_cwd = false, -- "true" or "false"
    },
  },

  -- stack view defaults
  stack_view = {
    tree_hl = true, -- toggle tree highlighting
  }
})

