local bind = require('keymap.bind')
local map_cr = bind.map_cr
local map_cu = bind.map_cu
local map_cmd = bind.map_cmd
local map_args = bind.map_args
require('keymap.config')

local plug_map = {
    -- TODO: move lua/modules/completion/config.lua and lua/keymap/config tab complete to here  	
--     ["i|<TAB>"]      = map_cmd('v:lua.tab_complete()'):with_expr():with_silent(),
--     ["i|<S-TAB>"]    = map_cmd('v:lua.s_tab_complete()'):with_silent():with_expr(),
    -- nvim-cmp
    -- ["i|<CR>"]       = map_cmd([[compe#confirm({ 'keys': "\<Plug>delimitMateCR", 'mode': '' })]]):with_noremap():with_expr():with_nowait(),

    -- person keymap
    ["n|mf"]             = map_cr("<cmd>lua require('internal.fsevent').file_event()<CR>"):with_silent():with_nowait():with_noremap();
    ["n|gb"]             = map_cr("BufferLinePick"):with_noremap():with_silent(),
    -- Packer
    ["n|<leader>pu"]     = map_cr("PackerUpdate"):with_silent():with_noremap():with_nowait();
    ["n|<leader>pi"]     = map_cr("PackerInstall"):with_silent():with_noremap():with_nowait();
    ["n|<leader>pc"]     = map_cr("PackerCompile"):with_silent():with_noremap():with_nowait();
    -- Lsp mapp work when insertenter and lsp start
    ["n|<leader>li"]     = map_cr("LspInfo"):with_noremap():with_silent():with_nowait(),
    ["n|<leader>ll"]     = map_cr("LspLog"):with_noremap():with_silent():with_nowait(),
    ["n|<leader>lr"]     = map_cr("LspRestart"):with_noremap():with_silent():with_nowait(),

    -- scroll down hover doc or scroll in definition preview
    ["n|<C-f>"]          = map_cmd("<cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>"):with_silent():with_noremap():with_nowait(),
    -- scroll up hover doc or scroll in definition preview
    ["n|<C-b>"]          = map_cmd("<cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>"):with_silent():with_noremap():with_nowait(),
    -- no impact?
    ["n|go"]             = map_cr('Lspsaga show_line_diagnostics'):with_noremap():with_silent(),
    ["n|[e"]             = map_cr('Lspsaga diagnostic_jump_next'):with_noremap():with_silent(),
    ["n|]e"]             = map_cr('Lspsaga diagnostic_jump_prev'):with_noremap():with_silent(),

    -- nnoremap <silent> K <cmd>lua require('lspsaga.hover').render_hover_doc()<CR>
    ["n|K"]              = map_cr("Lspsaga hover_doc"):with_noremap():with_silent(),

-- code action
-- nnoremap <silent><leader>ca <cmd>lua require('lspsaga.codeaction').code_action()<CR>
-- vnoremap <silent><leader>ca :<C-U>lua require('lspsaga.codeaction').range_code_action()<CR>

    ["n|ga"]             = map_cr("Lspsaga code_action"):with_noremap():with_silent(),
    ["v|ga"]             = map_cu("Lspsaga range_code_action"):with_noremap():with_silent(),

    ["n|gz"]             = map_cr('Lspsaga preview_definition'):with_noremap():with_silent(),

    ["n|gd"]             = map_cmd("<cmd>lua vim.lsp.buf.definition()<CR>"):with_noremap():with_silent(),
    ["n|gD"]             = map_cmd("<cmd>lua vim.lsp.buf.implementation()<CR>"):with_noremap():with_silent(),
    ["n|gr"]             = map_cmd("<cmd>lua vim.lsp.buf.references()<CR>"):with_noremap():with_silent(),
--    ["n|gi"]             = map_cmd("<cmd>lua vim.lsp.buf.implementation()<CR>"):with_noremap():with_silent(),
    --  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    --https://github.com/tami5/lspsaga.nvim/wiki
    ["n|gs"]             = map_cr('Lspsaga signature_help'):with_noremap():with_silent(),
    ["n|<leader>gr"]     = map_cr('Lspsaga rename'):with_noremap():with_silent(),


    -- lsp provider to find the cursor word definition and reference
    -- nnoremap <silent> gh <cmd>lua require'lspsaga.provider'.lsp_finder()<CR>
    ["n|gh"]             = map_cr('Lspsaga lsp_finder'):with_noremap():with_silent(),

    ["n|gt"]             = map_cmd("<cmd>lua vim.lsp.buf.type_definition()<CR>"):with_noremap():with_silent(),

    -- ["n|<Leader>cw"]     = map_cmd("<cmd>lua vim.lsp.buf.workspace_symbol()<CR>"):with_noremap():with_silent(),
    ["n|gw"]             = map_cmd("<cmd>lua vim.lsp.buf.workspace_symbol()<CR>"):with_noremap():with_silent(),
    ["n|<Leader>sd"]     = map_cr('Lspsaga show_line_diagnostics'):with_noremap():with_silent(),
    ["n|<Leader>ct"]      = map_args("Template"),
    ["n|<Leader>tf"]     = map_cu('DashboardNewFile'):with_noremap():with_silent(),
    -- Plugin nvim-tree
    ["n|<Leader>e"]      = map_cr('NvimTreeToggle'):with_noremap():with_silent(),
    ["n|<Leader>f"]      = map_cr('NvimTreeFindFile'):with_noremap():with_silent(),
    -- Plugin MarkdownPreview
    ["n|<Leader>om"]     = map_cu('MarkdownPreview'):with_noremap():with_silent(),
    -- Plugin DadbodUI
    ["n|<Leader>od"]     = map_cr('DBUIToggle'):with_noremap():with_silent(),
    -- Plugin Floaterm
    ["n|<A-d>"]          = map_cu('Lspsaga open_floaterm'):with_noremap():with_silent(),
    ["t|<A-d>"]          = map_cu([[<C-\><C-n>:Lspsaga close_floaterm<CR>]]):with_noremap():with_silent(),
    ["n|<Leader>g"]      = map_cu("Lspsaga open_floaterm lazygit"):with_noremap():with_silent(),
    -- Far.vim
    ["n|<Leader>fz"]     = map_cr('Farf'):with_noremap():with_silent();
    ["v|<Leader>fz"]     = map_cr('Farf'):with_noremap():with_silent();
    -- Plugin Telescope
    ["n|<Leader>bb"]     = map_cu('Telescope buffers'):with_noremap():with_silent(),
    ["n|<Leader>fa"]     = map_cu('DashboardFindWord'):with_noremap():with_silent(),
    ["n|<Leader>fb"]     = map_cu('Telescope file_browser'):with_noremap():with_silent(),
    ["n|<Leader>ff"]     = map_cu('DashboardFindFile'):with_noremap():with_silent(),
    ["n|<Leader>fg"]     = map_cu('Telescope git_files'):with_noremap():with_silent(),
    ["n|<Leader>fw"]     = map_cu('Telescope grep_string'):with_noremap():with_silent(),
    ["n|<Leader>fh"]     = map_cu('DashboardFindHistory'):with_noremap():with_silent(),
    ["n|<Leader>fl"]     = map_cu('Telescope loclist'):with_noremap():with_silent(),
    ["n|<Leader>fc"]     = map_cu('Telescope git_commits'):with_noremap():with_silent(),
    ["n|<Leader>ft"]     = map_cu('Telescope help_tags'):with_noremap():with_silent(),
    ["n|<Leader>fd"]     = map_cu('Telescope dotfiles path='..os.getenv("HOME")..'/.dotfiles'):with_noremap():with_silent(),
    ["n|<Leader>fs"]     = map_cu('Telescope gosource'):with_noremap():with_silent(),
    -- prodoc
    ["n|gcc"]            = map_cu('ProComment'):with_noremap():with_silent(),
    ["x|gcc"]            = map_cr('ProComment'),
    ["n|gcj"]            = map_cu('ProDoc'):with_silent():with_silent(),
    -- Plugin acceleratedjk
    ["n|j"]              = map_cmd('v:lua.enhance_jk_move("j")'):with_silent():with_expr(),
    ["n|k"]              = map_cmd('v:lua.enhance_jk_move("k")'):with_silent():with_expr(),
    -- Plugin QuickRun
    ["n|<Leader>r"]     = map_cr("<cmd> lua require'internal.quickrun'.run_command()"):with_noremap():with_silent(),
    -- Plugin Vista
    ["n|<Leader>v"]      = map_cu('Vista'):with_noremap():with_silent(),
    -- Plugin vim-operator-surround
    ["n|sa"]             = map_cmd("<Plug>(operator-surround-append)"):with_silent(),
    ["n|sd"]             = map_cmd("<Plug>(operator-surround-delete)"):with_silent(),
    ["n|sr"]             = map_cmd("<Plug>(operator-surround-replace)"):with_silent(),
    -- Plugin hrsh7th/vim-eft
    ["n|;"]              = map_cmd("v:lua.enhance_ft_move(';')"):with_expr(),
    ["x|;"]              = map_cmd("v:lua.enhance_ft_move(';')"):with_expr(),
    ["n|f"]              = map_cmd("v:lua.enhance_ft_move('f')"):with_expr(),
    ["x|f"]              = map_cmd("v:lua.enhance_ft_move('f')"):with_expr(),
    ["o|f"]              = map_cmd("v:lua.enhance_ft_move('f')"):with_expr(),
    ["n|F"]              = map_cmd("v:lua.enhance_ft_move('F')"):with_expr(),
    ["x|F"]              = map_cmd("v:lua.enhance_ft_move('F')"):with_expr(),
    ["o|F"]              = map_cmd("v:lua.enhance_ft_move('F')"):with_expr(),
    -- Plugin vim_niceblock
    ["x|I"]              = map_cmd("v:lua.enhance_nice_block('I')"):with_expr(),
    ["x|gI"]             = map_cmd("v:lua.enhance_nice_block('gI')"):with_expr(),
    ["x|A"]              = map_cmd("v:lua.enhance_nice_block('A')"):with_expr(),
    -- nvim cmp mapping
    --  ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
    --  ["n|<C-b>"]     = map_cmd("<cmd> lua require''.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }))::with_noremap():with_silent(),,


--     vim.api.nvim_set_keymap('n', '<F5>', '<Cmd>lua require("dap").continue()<CR>', opts)
    ["n|<F5>"]           = map_cmd("<cmd> lua require('dap').continue()<CR>"):with_noremap():with_silent(),
    -- "''" must this styep
-- --     vim.api.nvim_set_keymap('n', '<F10>', '<Cmd>lua require("dap").step_over()<CR>', opts)
    ["n|<F10>"]           = map_cmd("<cmd> lua require('dap').step_over()<CR>"):with_noremap():with_silent(),
-- --     vim.api.nvim_set_keymap('n', '<F11>', '<Cmd>lua require("dap").step_into()<CR>', opts)
    ["n|<F11>"]           = map_cmd("<cmd> lua require('dap').step_into()<CR>"):with_noremap():with_silent(),
-- --     vim.api.nvim_set_keymap('n', '<F12>', '<Cmd>lua require("dap").step_out()<CR>', opts)
    ["n|<F12>"]           = map_cmd("<cmd> lua require('dap').setp_out()<CR>"):with_noremap():with_silent(),
-- --     vim.api.nvim_set_keymap('n', '<leader>b', '<Cmd>lua require("dap").toggle_breakpoint()<CR>', opts)
    ["n|<leader>b"]           = map_cmd("<cmd> lua require('dap').toggle_breakpoint()<CR>"):with_noremap():with_silent(),
-- --     vim.api.nvim_set_keymap('n', '<leader>dr', '<Cmd>lua require("dap").repl.open()<CR>', opts)
    ["n|<leader>dr"]           = map_cmd("<cmd> lua require('dap').repl.open()<CR>"):with_noremap():with_silent(),
-- --     vim.api.nvim_set_keymap('n', '<leader>di', '<Cmd>lua require("dapui").toggle()<CR>', opts)
    ["n|<leader>di"]           = map_cmd("<cmd> lua require('dapui').toggle()<CR>"):with_noremap():with_silent(),


  --   -- Plugin dap
  --   ["n|<F6>"] = map_cr("lua require('dap').continue()"):with_noremap()
  --       :with_silent(),
  --   ["n|<leader>dr"] = map_cr("lua require('dap').continue()"):with_noremap()
  --       :with_silent(),
  --   ["n|<leader>dd"] = map_cr("lua require('dap').disconnect()"):with_noremap()
  --       :with_silent(),
  --   ["n|<leader>db"] = map_cr("lua require('dap').toggle_breakpoint()"):with_noremap()
  --       :with_silent(),
  --   ["n|<leader>dB"] = map_cr(
  --       "lua require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))"):with_noremap()
  --       :with_silent(),
  --   ["n|<leader>dbl"] = map_cr("lua require('dap').list_breakpoints()"):with_noremap()
  --       :with_silent(),
  --   ["n|<leader>drc"] = map_cr("lua require('dap').run_to_cursor()"):with_noremap()
  --       :with_silent(),
  --   ["n|<leader>drl"] = map_cr("lua require('dap').run_last()"):with_noremap()
  --       :with_silent(),
  --   ["n|<F9>"] = map_cr("lua require('dap').step_over()"):with_noremap()
  --       :with_silent(),
  --   ["n|<leader>dv"] = map_cr("lua require('dap').step_over()"):with_noremap()
  --       :with_silent(),
  --   ["n|<F10>"] = map_cr("lua require('dap').step_into()"):with_noremap()
  --       :with_silent(),
  --   ["n|<leader>di"] = map_cr("lua require('dap').step_into()"):with_noremap()
  --       :with_silent(),
  --   ["n|<F11>"] = map_cr("lua require('dap').step_out()"):with_noremap()
  --       :with_silent(),
  --   ["n|<leader>do"] = map_cr("lua require('dap').step_out()"):with_noremap()
  --       :with_silent(),
  --   ["n|<leader>dl"] = map_cr("lua require('dap').repl.open()"):with_noremap()
  --       :with_silent()

    ["n|<Leader>p"]     = map_cr("<cmd> lua require'nabla'.popup()"):with_noremap():with_silent(),
    -- knap set 
    ["n|<F7>"]           = map_cmd("<cmd> lua require('knap').toggle_autopreviewing()<CR>"):with_noremap():with_silent(),
    ["i|<F7>"]           = map_cmd("<cmd> lua require('knap').toggle_autopreviewing()<CR>"):with_noremap():with_silent(),
    ["n|<c-p>"]          = map_cr("<cmd> lua require('fzf-lua').files()"):with_noremap():with_silent(),
    --["n|<c->"]          = map_cr("<cmd> lua require('fzf-lua').grep_project()"):with_noremap():with_silent(),
    ["n|<c-g>"]          = map_cr("<cmd> lua require('fzf-lua').grep_cword()"):with_noremap():with_silent(),
    ["n|<c-\\>"]          = map_cr("<cmd> lua require('fzf-lua').buffers()"):with_noremap():with_silent(),
    ["n|<c-l>"]          = map_cr("<cmd> lua require('fzf-lua').live_grep_glob()"):with_noremap():with_silent(),
    ["n|<F1>"]          = map_cr("<cmd> lua require('fzf-lua').help_tags()"):with_noremap():with_silent(),
    ["n|<c-k>"]          = map_cr("<cmd> lua require('fzf-lua').builtin()"):with_noremap():with_silent(),
    -- require("fzf-lua").utils.info(
    -- "|<C-\\> buffers|<C-p> files|<C-g> grep|<C-l> live grep|<C-k> builtin|<F1> help|")

    -- 0.9 before nvim cscope set 
    ["n|<Leader>cg"]     = map_cr('cs f g <C-R>=expand("<cword>")<CR>'):with_noremap():with_silent(),
    ["n|<Leader>cc"]     = map_cr('cs f c <C-R>=expand("<cword>")<CR>'):with_noremap():with_silent(),
    ["n|<Leader>cd"]     = map_cr('cs f d <C-R>=expand("<cword>")<CR>'):with_noremap():with_silent(),
    ["n|<Leader>cy"]     = map_cr('cs f e <C-R>=expand("<cword>")<CR>'):with_noremap():with_silent(),
    ["n|<Leader>cf"]     = map_cr('cs f f <C-R>=expand("<cword>")<CR>'):with_noremap():with_silent(),
    ["n|<Leader>ci"]     = map_cr('cs f i <C-R>=expand("<cword>")<CR>'):with_noremap():with_silent(),
    ["n|<Leader>cs"]     = map_cr('cs f s <C-R>=expand("<cword>")<CR>'):with_noremap():with_silent(),
    --["n|<Leader>ct"]     = map_cr('cs f t <C-R>=expand("<cword>")<CR>'):with_noremap():with_silent(),
    --  { "<leader>lq", "<cmd>LBQuestions<cr>", desc = "List Questions" },
    -- { "<leader>ll", "<cmd>LBQuestion<cr>", desc = "View Question" },
    -- { "<leader>lr", "<cmd>LBReset<cr>", desc = "Reset Code" },
    -- { "<leader>lt", "<cmd>LBTest<cr>", desc = "Run Code" },
    -- { "<leader>ls", "<cmd>LBSubmit<cr>", desc = "Submit Code" },
    ["n|<Leader>lq"]  = map_cr("<cmd> LBQuestions"):with_noremap():with_silent(),
    ["n|<Leader>ll"]  = map_cr("<cmd> LBQuestion"):with_noremap():with_silent(),
    ["n|<Leader>lr"]  = map_cr("<cmd> LBReset"):with_noremap():with_silent(),
    ["n|<Leader>lt"]  = map_cr("<cmd> LBTest"):with_noremap():with_silent(),
    ["n|<Leader>ls"]  = map_cr("<cmd> LBSubmit"):with_noremap():with_silent(),

};

bind.nvim_load_mapping(plug_map)
