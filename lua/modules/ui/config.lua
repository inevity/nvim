local pack = require "core.pack"
local config = {}

function config.galaxyline()
-- require('modules.ui.eviline')
--  require("galaxyline.themes.eviline")
--  require("galaxyline.themes.colors")
--  require("galaxyline.themes.neonline")
  require("galaxyline.themes.spaceline")

end

function config.nvim_bufferline()
  require('bufferline').setup{
    options = {
      modified_icon = '✥',
      buffer_close_icon = '',
      -- how key map let to define
      -- mappings = true,
      always_show_bufferline = false,
    }
  }
end

function config.dashboard()
  local home = os.getenv('HOME')
  vim.g.dashboard_footer_icon = '🐬 '
  vim.g.dashboard_preview_command = 'cat'
  vim.g.dashboard_preview_pipeline = 'lolcat -F 0.3'
  vim.g.dashboard_preview_file = home .. '/.config/nvim/static/neovim.cat'
  vim.g.dashboard_preview_file_height = 12
  vim.g.dashboard_preview_file_width = 80
  -- dashborad config here
  vim.g.dashboard_default_executive = 'telescope'
  vim.g.dashboard_custom_section = {
    last_session = {
      description = {'  Recently laset session                  SPC s l'},
      command =  'SessionLoad'},
    find_history = {
      description = {'  Recently opened files                   SPC f h'},
      command =  'DashboardFindHistory'},
    find_file  = {
      description = {'  Find  File                              SPC f f'},
      command = 'Telescope find_files find_command=rg,--hidden,--files'},
    new_file = {
     description = {'  File Browser                            SPC f b'},
     command =  'Telescope file_browser'},
    find_word = {
     description = {'  Find  word                              SPC f w'},
     command = 'DashboardFindWord'},
    find_dotfiles = {
     description = {'  Open Personal dotfiles                  SPC f d'},
     command = 'Telescope dotfiles path=' .. home ..'/.dotfiles'},
    go_source = {
     description = {'  Find Go Source Code                     SPC f s'},
     command = 'Telescope gosource'},
  }
end

function config.nvim_tree()
--   vim.g.nvim_tree_follow = 1
--   vim.g.nvim_tree_hide_dotfiles = 1
--   TODO: fix
--   vim.g.nvim_tree_indent_markers = 1
--   vim.g.nvim_tree_bindings = {
--     ["l"] = ":lua require'nvim-tree'.on_keypress('edit')<CR>",
--     ["s"] = ":lua require'nvim-tree'.on_keypress('vsplit')<CR>",
--     ["i"] = ":lua require'nvim-tree'.on_keypress('split')<CR>",
--   }
 -- vim.g.nvim_tree_icons = {
 --   default =  '',
 --   symlink =  '',
 --   git = {
 --    unstaged = "✚",
 --    staged =  "✚",
 --    unmerged =  "≠",
 --    renamed =  "≫",
 --    untracked = "★",
 --   },
 -- }
  -- renderer.icons.glyphs
  require('nvim-tree').setup {
--     update_focused_file = {
--       -- false
--       enable      = true,
--       update_cwd  = false,
--       ignore_list = {}
--     },
-- --    filters = { dotfiles = false }
-- --     view.mappings.list
     view = {
       width = 30,
       hide_root_folder = false,
       side = 'left',
       --true
       adaptive_size = true,
       mappings = {
         custom_only = false,
         list = {
                 ["l"] = ":lua require'nvim-tree'.on_keypress('edit')<CR>",
                 ["s"] = ":lua require'nvim-tree'.on_keypress('vsplit')<CR>",
                 ["i"] = ":lua require'nvim-tree'.on_keypress('split')<CR>",
               }
       },
       number = false,
       relativenumber = false,
       signcolumn = "yes"
     },
--     renderer = {
--       glyphs = {
--              default = "",
--              symlink = "",
--              bookmark = "",
--              folder = {
--                arrow_closed = "",
--                arrow_open = "",
--                default = "",
--                open = "",
--                empty = "",
--                empty_open = "",
--                symlink = "",
--                symlink_open = "",
--              },
--              git = {
--                unstaged = "✗",
--                staged = "✓",
--                unmerged = "",
--                renamed = "➜",
--                untracked = "★",
--                deleted = "",
--                ignored = "◌",
--              },
--       },
--     },
  }

  -- On Ready Event for Lazy Loading work
  require("nvim-tree.events").on_nvim_tree_ready(
    function()
      vim.cmd("NvimTreeRefresh")
    end
  )
end

function config.gitsigns()
 -- if not packer_plugins['plenary.nvim'].loaded then
  if not pack.is_plugin_loaded('plenary.nvim')   then
    -- vim.cmd [[packadd plenary.nvim]]
    require("lazy").load({ plugins = { "plenary.nvim" } })
  end
  require('gitsigns').setup {
    signs = {
      add = {hl = 'GitGutterAdd', text = '▋'},
      change = {hl = 'GitGutterChange',text= '▋'},
      delete = {hl= 'GitGutterDelete', text = '▋'},
      topdelete = {hl ='GitGutterDeleteChange',text = '▔'},
      changedelete = {hl = 'GitGutterChange', text = '▎'},
    },

    on_attach = function(bufnr)
        local gitsigns = require('gitsigns')
        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end
        -- Navigation
        map('n', ']c', function()
          if vim.wo.diff then
            vim.cmd.normal({']c', bang = true})
          else
            gitsigns.nav_hunk('next')
          end
        end)
    
        map('n', '[c', function()
          if vim.wo.diff then
            vim.cmd.normal({'[c', bang = true})
          else
            gitsigns.nav_hunk('prev')
          end
        end)
    
        -- Actions
        map('n', '<leader>hs', gitsigns.stage_hunk)
        map('n', '<leader>hr', gitsigns.reset_hunk)
    
        map('v', '<leader>hs', function()
          gitsigns.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') })
        end)
    
        map('v', '<leader>hr', function()
          gitsigns.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') })
        end)
    
        map('n', '<leader>hS', gitsigns.stage_buffer)
        map('n', '<leader>hR', gitsigns.reset_buffer)
        map('n', '<leader>hp', gitsigns.preview_hunk)
        map('n', '<leader>hi', gitsigns.preview_hunk_inline)
    
        map('n', '<leader>hb', function()
          gitsigns.blame_line({ full = true })
        end)
    
        map('n', '<leader>hd', gitsigns.diffthis)
    
        map('n', '<leader>hD', function()
          gitsigns.diffthis('~')
        end)
    
        map('n', '<leader>hQ', function() gitsigns.setqflist('all') end)
        map('n', '<leader>hq', gitsigns.setqflist)
    
        -- Toggles
        map('n', '<leader>tb', gitsigns.toggle_current_line_blame)
        map('n', '<leader>tw', gitsigns.toggle_word_diff)
    
        -- Text object
        map({'o', 'x'}, 'ih', gitsigns.select_hunk)
      end

--    keymaps = {
--       -- Default keymap options
--       noremap = true,
--       buffer = true,
--
--       ['n ]g'] = { expr = true, "&diff ? ']g' : '<cmd>lua require\"gitsigns\".next_hunk()<CR>'"},
--       ['n [g'] = { expr = true, "&diff ? '[g' : '<cmd>lua require\"gitsigns\".prev_hunk()<CR>'"},
--
--       ['n <leader>hs'] = '<cmd>lua require"gitsigns".stage_hunk()<CR>',
--       ['n <leader>hu'] = '<cmd>lua require"gitsigns".undo_stage_hunk()<CR>',
--       ['n <leader>hr'] = '<cmd>lua require"gitsigns".reset_hunk()<CR>',
--       ['n <leader>hp'] = '<cmd>lua require"gitsigns".preview_hunk()<CR>',
--       ['n <leader>hb'] = '<cmd>lua require"gitsigns".blame_line()<CR>',
--
--       -- Text objects
--       ['o ih'] = ':<C-U>lua require"gitsigns".text_object()<CR>',
--       ['x ih'] = ':<C-U>lua require"gitsigns".text_object()<CR>'
--     },
  }


end

function config.indent_blakline()
  require("ibl").setup()
  vim.g.indent_blankline_char = "│"
  vim.g.indent_blankline_show_first_indent_level = true
  vim.g.indent_blankline_filetype_exclude = {
    "startify",
    "dashboard",
    "dotooagenda",
    "log",
    "fugitive",
    "gitcommit",
    "packer",
    "vimwiki",
    "markdown",
    "json",
    "txt",
    "vista",
    "help",
    "todoist",
    "NvimTree",
    "peekaboo",
    "git",
    "TelescopePrompt",
    "undotree",
    "flutterToolsOutline",
    "" -- for all buffers without a file type
  }
  vim.g.indent_blankline_buftype_exclude = {"terminal", "nofile"}
  vim.g.indent_blankline_show_trailing_blankline_indent = false
  vim.g.indent_blankline_show_current_context = true
  vim.g.indent_blankline_context_patterns = {
    "class",
    "function",
    "method",
    "block",
    "list_literal",
    "selector",
    "^if",
    "^table",
    "if_statement",
    "while",
    "for"
  }
  vim.api.nvim_create_user_command("IndentBlanklineRefresh", function()
    -- require("ibl").refresh(nil)
    -- require("ibl").refresh_all()
    require("ibl").refresh(vim.api.nvim_get_current_buf())
  end, {})

  -- because lazy load indent-blankline so need readd this autocmd
  -- first comment,if installed ,then enable.
  vim.cmd('autocmd CursorMoved * IndentBlanklineRefresh')


end

return config
