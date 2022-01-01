local config = {}

function config.nvim_lsp()
  require('modules.completion.lspconfig')
end

function config.nvim_compe()
  require'compe'.setup {
    enabled = true;
    debug = false;
    min_length = 1;
    preselect = 'always';
    allow_prefix_unmatch = false;
    source = {
      path = true;
      buffer = true;
      calc = true;
      vsnip = true;
      nvim_lsp = true;
      nvim_lua = true;
      spell = true;
      tags = true;
      snippets_nvim = false;
    };
  }
end

function config.nvim_cmp()
   local cmp = require'cmp'
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
    mapping = {
      ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
      ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
      ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
      ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
      ['<C-e>'] = cmp.mapping({
        i = cmp.mapping.abort(),
        c = cmp.mapping.close(),
      }),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    },
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'vsnip' }, -- For vsnip users.
      -- { name = 'luasnip' }, -- For luasnip users.
      -- { name = 'ultisnips' }, -- For ultisnips users.
      -- { name = 'snippy' }, -- For snippy users.
    }, {
      { name = 'buffer' },
    })
  })
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
  if not packer_plugins['plenary.nvim'].loaded then
    vim.cmd [[packadd plenary.nvim]]
    vim.cmd [[packadd popup.nvim]]
    vim.cmd [[packadd telescope-fzy-native.nvim]]
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

return config
