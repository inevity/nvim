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

function config.knap()
    local gknapsettings = {
       -- htmloutputext = "html",
       -- htmltohtml = "none",
       -- htmltohtmlviewerlaunch = "falkon %outputfile%",
       -- htmltohtmlviewerrefresh = "none",

       -- mdoutputext = "html",
       -- mdtohtml = "pandoc --standalone %docroot% -o %outputfile%",
       -- mdtohtmlviewerlaunch = "falkon %outputfile%",
       -- mdtohtmlviewerrefresh = "none",

       -- mdtopdf = "pandoc %docroot% -o %outputfile%",
       -- mdtopdfviewerlaunch = "sioyek %outputfile%",
       -- mdtopdfviewerrefresh = "none",

       -- markdownoutputext = "html",

       -- markdowntohtml = "pandoc --standalone %docroot% -o %outputfile%",
       -- markdowntohtmlviewerlaunch = "falkon %outputfile%",
       -- markdowntohtmlviewerrefresh = "none",

       -- markdowntopdf = "pandoc %docroot% -o %outputfile%",
       -- markdowntopdfviewerlaunch = "sioyek %outputfile%",
       -- markdowntopdfviewerrefresh = "none",

       -- --texoutputext = "pdf",
       -- -- textopdf = "pdflatex -synctex=1 -halt-on-error -interaction=batchmode %docroot%",
       -- -- textopdf = "latexmk", 
     ----   textopdfviewerlaunch = "mupdf %outputfile%",
     ----   textopdfviewerrefresh = "kill -HUP %pid%",

     ----   textopdfviewerlaunch = "sioyek --inverse-search 'nvim --headless -es --cmd \"lua require('\"'\"'knaphelper'\"'\"').relayjump('\"'\"'%servername%'\"'\"','\"'\"'%1'\"'\"',%2,0)\"' --reuse-instance %outputfile%",
     ----   textopdfviewerrefresh = "none",
     ----   textopdfforwardjump = "sioyek --inverse-search 'nvim --headless -es --cmd \"lua require('\"'\"'knaphelper'\"'\"').relayjump('\"'\"'%servername%'\"'\"','\"'\"'%1'\"'\"',%2,0)\"' --reuse-instance --forward-search-file %srcfile% --forward-search-line %line% %outputfile%"
       -- texoutputext = "pdf",
       -- textopdf = "pdflatex -interaction=batchmode -halt-on-error -synctex=1 %docroot%",
       -- -- textopdfviewerlaunch = "sioyek --inverse-search 'nvim --headless -es --cmd \"lua require('\"'\"'knaphelper'\"'\"').relayjump('\"'\"'%servername%'\"'\"','\"'\"'%1'\"'\"',%2,%3)\"' --reuse-instance %outputfile%",
       -- textopdfviewerlaunch = "/Applications/sioyek.app/Contents/MacOS/sioyek --inverse-search 'nvim --headless -es --cmd \"lua require('\"'\"'knaphelper'\"'\"').relayjump('\"'\"'%servername%'\"'\"','\"'\"'%1'\"'\"',%2,%3)\"' --reuse-instance %outputfile%",
       -- textopdfviewerrefresh = "none",
       -- textopdfforwardjump = "/Applications/sioyek.app/Contents/MacOS/sioyek --inverse-search 'nvim --headless -es --cmd \"lua require('\"'\"'knaphelper'\"'\"').relayjump('\"'\"'%servername%'\"'\"','\"'\"'%1'\"'\"',%2,%3)\"' --reuse-instance --forward-search-file %srcfile% --forward-search-line %line% %outputfile%",
       -- textopdfshorterror = "A=%outputfile% ; LOGFILE=\"${A%.pdf}.log\" ; rubber-info \"$LOGFILE\" 2>&1 | head -n 1",
       -- delay = 250
        texoutputext = "pdf",
        textopdf = "pdflatex -synctex=1 -halt-on-error -interaction=batchmode %docroot%",
        --textopdfviewerlaunch = "open -a mupdf %outputfile%",
        --textopdfviewerlaunch = "mupdf-gl %outputfile%",
        -- textopdfviewerlaunch = "open %outputfile%",
        textopdfviewerlaunch = "open -a Skim  %outputfile%",
        textopdfviewerrefresh = "kill -HUP %pid%"

    }
    vim.g.knap_settings = gknapsettings
end

return config
