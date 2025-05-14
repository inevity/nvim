local pack = require('core.pack')

local config = {}



function config.nvim_lsp()
  require('modules.completion.lspconfigp')
end


-- function config.nvim_compe()
--   require'compe'.setup {
--     enabled = true;
--     debug = false;
--     min_length = 1;
--     preselect = 'always';
--     allow_prefix_unmatch = false;
--     source = {
--       path = true;
--       buffer = true;
--       calc = true;
--       vsnip = true;
--       nvim_lsp = true;
--       nvim_lua = true;
--       spell = true;
--       tags = true;
--       snippets_nvim = false;
--     };
--   }
-- end


local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local feedkey = function(key, mode)
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
end


function config.nvim_cmp()
   local cmp = require'cmp'
   -- if not packer_plugins['cmp-buffer'].loaded then
   if not pack.is_plugin_loaded('cmp-buffer') then
     -- vim.cmd [[packadd cmp-nvim-lsp]]
     -- vim.cmd [[packadd cmp-buffer]]
     -- vim.cmd [[packadd cmp-path]]
     -- vim.cmd [[packadd cmp-cmdline]]
     require("lazy").load({ plugins = { "cmp-nvim-lsp", "cmp-buffer", "cmp-path", "cmp-cmdline", "cmp-vsnip", "vim-vsnip" } })
     -- self load
     -- vim.cmd [[packadd cmp-vsnip]]
     -- vim.cmd [[packadd vim-vsnip]]
   end
   cmp.setup({
    -- require'cmp'.setup {
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
        -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
      end,
    },
    -- TODO: ref nvim-cmp advanced config or nvim-rust config 
    -- TODO: move to keymap init
    -- TODO: only Ce and Tab ,CR function .
    mapping = {
      ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
      ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
      ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
 --     ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(
 --                       {
 --                         config = {
 --                           sources = {
 --                             { name = 'vsnip' }
 --                           }
 --                         }
 --                       }
 --                                                    ),
 --                       { 'i', 'c' }),
      ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
      ['<C-e>'] = cmp.mapping({
        i = cmp.mapping.abort(),
        c = cmp.mapping.close(),
      }),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
      ['<Tab>'] = function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            else
                fallback()
            end
      end,
--      TODO: move to keymap config
--       ["<Tab>"] = cmp.mapping(function(fallback)
--         if cmp.visible() then
--           cmp.select_next_item()
--         elseif vim.fn["vsnip#available"](1) == 1 then
--           feedkey("<Plug>(vsnip-expand-or-jump)", "")
--         elseif has_words_before() then
--           cmp.complete()
--         else
--           fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
--         end
--       end, { "i", "s" }),
-- 
--       ["<S-Tab>"] = cmp.mapping(function()
--         if cmp.visible() then
--           cmp.select_prev_item()
--         elseif vim.fn["vsnip#jumpable"](-1) == 1 then
--           feedkey("<Plug>(vsnip-jump-prev)", "")
--         end
--       end, { "i", "s" }),
    },
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'vsnip' }, -- For vsnip users.
  -- { name = 'luasnip' }, -- For luasnip users.
  -- { name = 'ultisnips' }, -- For ultisnips users.
  -- { name = 'snippy' }, -- For snippy users.
    }, {
      { name = 'buffer' },
      { name = 'path' },
      { name = 'crates' },

    })
  })

--     sources = cmp.config.sources({
--       { name = 'nvim_lsp' },
--       { name = 'vsnip' }, -- For vsnip users.
--     })

      -- Installed sources

--       sources = {
--         { name = 'nvim_lsp' },
--         { name = 'vsnip' },
--         { name = 'path' },
--         { name = 'buffer' },
--       },
--   })

   -- Set configuration for specific filetype.
--     cmp.setup.filetype('gitcommit', {
--       sources = cmp.config.sources({
--         { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it. 
--       }, {
--         { name = 'buffer' },
--       })
--     })
     -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
     cmp.setup.cmdline('/', {
       sources = {
         { name = 'buffer' }
       }
     })
   
     -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
     cmp.setup.cmdline(':', {
       sources = cmp.config.sources({
         { name = 'path' }
       }, {
         { name = 'cmdline' }
       })
     })
   
    -- Setup lspconfig.
--      local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
    -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
--      require('lspconfig')['<YOUR_LSP_SERVER>'].setup {
--        capabilities = capabilities
--      }

end

function config.vim_vsnip()
  vim.g.vsnip_snippet_dir = os.getenv('HOME') .. '/.config/nvim/snippets'
end

-- other snip config here  
function config.telescope()
  -- if not packer_plugins['plenary.nvim'].loaded then
  if not pack.is_plugin_loaded('plenary.nvim') then
    require("lazy").load({ plugins = { "plenary.nvim", "popup.nvim", "telescope-fzy-native.nvim" } })
    -- vim.cmd [[packadd plenary.nvim]]
    -- vim.cmd [[packadd popup.nvim]]
    -- vim.cmd [[packadd telescope-fzy-native.nvim]]
  end
  require('telescope').setup {
    defaults = {
      prompt_prefix = '🔭 ',
      prompt_position = 'top',
      selection_caret = " ",
      sorting_strategy = 'ascending',
      results_width = 0.6,
      file_previewer = require'telescope.previewers'.vim_buffer_cat.new,
      grep_previewer = require'telescope.previewers'.vim_buffer_vimgrep.new,
      qflist_previewer = require'telescope.previewers'.vim_buffer_qflist.new,
    },
    extensions = {
        fzy_native = {
            override_generic_sorter = false,
            override_file_sorter = true,
        }
    }
  }
  require('telescope').load_extension('fzy_native')
  require'telescope'.load_extension('dotfiles')
  require'telescope'.load_extension('gosource')
end

function config.vim_sonictemplate()
  vim.g.sonictemplate_postfix_key = '<C-,>'
  vim.g.sonictemplate_vim_template_dir = os.getenv("HOME").. '/.config/nvim/template'
end

function config.smart_input()
  require('smartinput').setup {
    ['go'] = { ';',':=',';' }
  }
end

function config.emmet()
  vim.g.user_emmet_complete_tag = 0
  vim.g.user_emmet_install_global = 0
  vim.g.user_emmet_install_command = 0
  vim.g.user_emmet_mode = 'i'
end

function config.crates()
 -- if not packer_plugins['plenary.nvim'].loaded then
  if not pack.is_plugin_loaded('plenary.nvim') then
    -- vim.cmd [[packadd plenary.nvim]]
    require("lazy").load({ plugins = { "plenary.nvim" } })
  end
  require('crates').setup {
      text = {
          loading = "  Loading...",
          version = "  %s",
          prerelease = "  %s",
          yanked = "  %s yanked",
          nomatch = "  Not found",
          upgrade = "  %s",
          error = "  Error fetching crate",
      },
      popup = {
          text = {
              title = "# %s",
              pill_left = "",
              pill_right = "",
              created_label = "created        ",
              updated_label = "updated        ",
              downloads_label = "downloads      ",
              homepage_label = "homepage       ",
              repository_label = "repository     ",
              documentation_label = "documentation  ",
              crates_io_label = "crates.io      ",
              categories_label = "categories     ",
              keywords_label = "keywords       ",
              prerelease = "%s pre-release",
              yanked = "%s yanked",
              enabled = "* s",
              transitive = "~ s",
              optional = "? %s",
              loading = " ...",
          },
      },
      src = {
          text = {
              prerelease = " pre-release ",
             yanked = " yanked ",
      },
    },
  }
end

return config
