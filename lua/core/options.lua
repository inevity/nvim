local global = require('core.global')

local function bind_option(options)
  for k, v in pairs(options) do
    if v == true or v == false then
      vim.cmd('set ' .. k)
    else
      vim.cmd('set ' .. k .. '=' .. v)
    end
  end
end

local function load_options()
  local global_local = {
    termguicolors  = true;
    mouse          = "nv";
    errorbells     = true;
    visualbell     = true;
    hidden         = true;
    fileformats    = "unix,mac,dos";
    magic          = true;
    virtualedit    = "block";
    encoding       = "utf-8";
    viewoptions    = "folds,cursor,curdir,slash,unix";
    sessionoptions = "curdir,help,tabpages,winsize";
    clipboard      = "unnamedplus";
    wildignorecase = true;
    wildignore     = ".git,.hg,.svn,*.pyc,*.o,*.out,*.jpg,*.jpeg,*.png,*.gif,*.zip,**/tmp/**,*.DS_Store,**/node_modules/**,**/bower_modules/**";
    backup         = false;
    writebackup    = false;
    swapfile       = false;
    directory      = global.cache_dir .. "swag/";
    undodir        = global.cache_dir .. "undo/";
    backupdir      = global.cache_dir .. "backup/";
    viewdir        = global.cache_dir .. "view/";
    spellfile      = global.cache_dir .. "spell/en.uft-8.add";
    history        = 2000;
    shada          = "!,'300,<50,@100,s10,h";
    backupskip     = "/tmp/*,$TMPDIR/*,$TMP/*,$TEMP/*,*/shm/*,/private/var/*,.vault.vim";
    smarttab       = true;
    shiftround     = true;
    timeout        = true;
    ttimeout       = true;
    timeoutlen     = 500;
    ttimeoutlen    = 10;
    -- Set updatetime for CursorHold
    -- 300ms of no cursor movement to trigger CursorHold
    updatetime     = 100;

    redrawtime     = 1500;
    ignorecase     = true;
    smartcase      = true;
    infercase      = true;
    incsearch      = true;
    wrapscan       = true;
    complete       = ".,w,b,k";
    inccommand     = "nosplit";
    grepformat     = "%f:%l:%c:%m";
    grepprg        = 'rg --hidden --vimgrep --smart-case --';
    breakat        = [[\ \	;:,!?]];
    startofline    = false;
    whichwrap      = "h,l,<,>,[,],~";
    splitbelow     = true;
    splitright     = true;
    switchbuf      = "useopen";
    backspace      = "indent,eol,start";
    diffopt        = "filler,iwhite,internal,algorithm:patience";
    completeopt    = "menu,menuone,noselect";
    jumpoptions    = "stack";
    showmode       = false;
    shortmess      = "aoOTIcF";
    scrolloff      = 2;
    sidescrolloff  = 5;
    foldlevelstart = 99;
    ruler          = false;
    list           = true;
    showtabline    = 2;
    winwidth       = 30;
    winminwidth    = 10;
    pumheight      = 15;
    helpheight     = 12;
    previewheight  = 12;
    showcmd        = false;
    cmdheight      = 2;
    cmdwinheight   = 5;
    equalalways    = false;
    laststatus     = 2;
    display        = "lastline";
    showbreak      = "↳  ";
    listchars      = "tab:»·,nbsp:+,trail:·,extends:→,precedes:←";
    pumblend       = 10;
    winblend       = 10;
  }

  local bw_local  = {
    undofile       = true;
    synmaxcol      = 2500;
    formatoptions  = "1jcroql";
    textwidth      = 80;
    expandtab      = true;
    autoindent     = true;
    tabstop        = 2;
    shiftwidth     = 2;
    softtabstop    = -1;
    breakindentopt = "shift:2,min:20";
    wrap           = false;
    linebreak      = true;
    number         = true;
    colorcolumn    = "80";
    foldenable     = true;
    signcolumn     = "yes";
    conceallevel   = 2;
    concealcursor  = "niv";
  }

  if global.is_mac then
    vim.g.clipboard = {
      name = "macOS-clipboard",
      copy = {
        ["+"] = "pbcopy",
        ["*"] = "pbcopy",
      },
      paste = {
        ["+"] = "pbpaste",
        ["*"] = "pbpaste",
      },
      cache_enabled = 0
    }
    vim.g.python_host_prog = '/usr/bin/python'
    vim.g.python3_host_prog = '/usr/local/bin/python3'
  end
  for name, value in pairs(global_local) do
    vim.o[name] = value
  end
  bind_option(bw_local)
end

-- vim.cmd([[
--   if exists('$TMUX')
--     let &t_SI = "\ePtmux;\e\e[1 q\e\\"
--     let &t_SR = "\ePtmux;\e\e[4 q\e\\"
-- "     let &t_EI = "\ePtmux;\e\e[2 q\e\\"
--   else
--     " insert
--     let &t_SI = "\<Esc>[1 q"
--     " replace
--     let &t_SR = "\<Esc>[4 q"
--     " normal
-- "     let &t_EI = "\<Esc>[2 q"
--   endif
-- ]])

load_options()
