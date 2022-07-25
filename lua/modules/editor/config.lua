local config = {}

function config.delimimate()
  vim.g.delimitMate_expand_cr = 0
  vim.g.delimitMate_expand_space = 1
  vim.g.delimitMate_smart_quotes = 1
  vim.g.delimitMate_expand_inside_quotes = 0
  vim.api.nvim_command('au FileType markdown let b:delimitMate_nesting_quotes = ["`"]')
end

function config.nvim_colorizer()
  require 'colorizer'.setup {
    css = { rgb_fn = true; };
    scss = { rgb_fn = true; };
    sass = { rgb_fn = true; };
    stylus = { rgb_fn = true; };
    vim = { names = true; };
    tmux = { names = false; };
    'javascript';
    'javascriptreact';
    'typescript';
    'typescriptreact';
    html = {
      mode = 'foreground';
    }
  }
end

function config.vim_cursorwod()
  vim.api.nvim_command('augroup user_plugin_cursorword')
  vim.api.nvim_command('autocmd!')
  vim.api.nvim_command('autocmd FileType NvimTree,lspsagafinder,dashboard,vista let b:cursorword = 0')
  vim.api.nvim_command('autocmd WinEnter * if &diff || &pvw | let b:cursorword = 0 | endif')
  vim.api.nvim_command('autocmd InsertEnter * let b:cursorword = 0')
  vim.api.nvim_command('autocmd InsertLeave * let b:cursorword = 1')
  vim.api.nvim_command('augroup END')
end

function config.vimtex()
    vim.g.vimtex_view_enabled = 0
    vim.g.vimtex_view_automatic = 0 
    -- viewer 
    -- vim.g.vimtex_view_method = 'zathura'
    -- or general interface 
 --   vim.g.vimtex_view_general_viewer = 'okular'
 --   vim.g.vimtex_view_general_options = [[--unique file:@pdf\#src:@line@tex]]
 --   vim.g.vimtex_view_general_options_latexmk = '--unique'

 -- vimtex_compiler_method = 'latexmk' default 
 --     let g:vimtex_compiler_latexmk = {
 --        \ 'build_dir' : '',
 --        \ 'callback' : 1,
 --        \ 'continuous' : 1,
 --        \ 'executable' : 'latexmk',
 --        \ 'hooks' : [],
 --        \ 'options' : [
 --        \   '-verbose',
 --        \   '-file-line-error',
 --        \   '-synctex=1',
 --        \   '-interaction=nonstopmode',
 --        \ ],
 --        \}
 --


-- vimtex_compiler_latexmk_engine 
--     let g:vimtex_compiler_latexmk_engines = {
--        \ '_'                : '-pdf',
--        \ 'pdfdvi'           : '-pdfdvi',
--        \ 'pdfps'            : '-pdfps',
--        \ 'pdflatex'         : '-pdf',
--        \ 'luatex'           : '-lualatex',
--        \ 'lualatex'         : '-lualatex',
--        \ 'xelatex'          : '-xelatex',
--        \ 'context (pdftex)' : '-pdf -pdflatex=texexec',
--        \ 'context (luatex)' : '-pdf -pdflatex=context',
--        \ 'context (xetex)'  : '-pdf -pdflatex=''texexec --xtx''',
--        \}

--    vim.g.vimtex_compiler_latexmk_engines = {
--        _ = '-xelatex'
--    }
    vim.g.tex_comment_nospell = 1
   -- vim.g.vimtex_compiler_progname = 'nvr'
end

return config
