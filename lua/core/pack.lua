-- local fn,uv,api = vim.fn,vim.loop,vim.api
-- local vim_path = require('core.global').vim_path
-- local data_dir = require('core.global').data_dir
-- local modules_dir = vim_path .. '/lua/modules'
-- local packer_compiled = data_dir..'packer_compiled.vim'
-- local compile_to_lua = data_dir..'lua/_compiled.lua'
-- local packer = nil
-- 
-- -- packer define 
-- -- load_plugins from path
-- -- load_packer and init 
-- -- function Packer:init_ensure_plugins()
-- local Packer = {}
-- Packer.__index = Packer
-- 
-- function Packer:load_plugins()
--   self.repos = {}
-- 
--   local get_plugins_list = function ()
--     local list = {}
--     local tmp = vim.split(fn.globpath(modules_dir,'*/plugins.lua'),'\n')
--     for _,f in ipairs(tmp) do
--       list[#list+1] = f:sub(#modules_dir - 6,-1)
--     end
--     return list
--   end
-- 
--   local plugins_file = get_plugins_list()
--   for _,m in ipairs(plugins_file) do
--     local repos = require(m:sub(0,#m-4))
--     for repo,conf in pairs(repos) do
--       self.repos[#self.repos+1] = vim.tbl_extend('force',{repo},conf)
--     end
--   end
-- end
-- 
-- function Packer:load_packer()
--   if not packer then
--     api.nvim_command('packadd packer.nvim')
--     packer = require('packer')
--   end
--   -- packer.init() from 
--   packer.init({
--     compile_path = packer_compiled,
--     max_jobs = 16,
--     git = {
-- 		clone_timeout = 120,
--     -- default_url_format = 'https://hub.fastgit.org/%s'
--     -- default_url_format = 'https://hub.fastgit.xyz/%s'
--     },
-- 		-- trace
-- 		log = { level = 'debug' },
-- 
--     disable_commands = true
--   })
-- 
--   packer.reset()
--   local use = packer.use
--   self:load_plugins()
--   use {"wbthomason/packer.nvim", opt = true }
--   for _,repo in ipairs(self.repos) do
--     use(repo)
--   end
-- end
-- 
-- function Packer:init_ensure_plugins()
--   local packer_dir = data_dir..'pack/packer/opt/packer.nvim'
--   local state = uv.fs_stat(packer_dir)
--   if not state then
--     local cmd = "!git clone https://github.com/wbthomason/packer.nvim " ..packer_dir
--     api.nvim_command(cmd)
--     uv.fs_mkdir(data_dir..'lua',511,function()
--       assert("make compile path dir faield")
--     end)
--     self:load_packer()
--     packer.install()
--   end
-- end
-- 
-- -- plugin module how create!!! key ?
-- local plugins = setmetatable({}, {
--   __index = function(_, key)
--     if not packer then
--       Packer:load_packer()
--     end
--     return packer[key]
--   end
-- })
-- 
-- function plugins.ensure_plugins()
--   Packer:init_ensure_plugins()
-- end
-- 
-- function plugins.convert_compile_file()
--   local lines = {}
--   local lnum = 1
--   lines[#lines+1] = 'vim.cmd [[packadd packer.nvim]]\n'
-- 
--   for line in io.lines(packer_compiled) do
--     lnum = lnum + 1
--     if lnum > 15 then
--       lines[#lines+1] = line .. '\n'
--       if line == 'END' then
--         break
--       end
--     end
--   end
--   table.remove(lines,#lines)
-- 
--   if vim.fn.isdirectory(data_dir .. 'lua') ~= 1 then
--     os.execute('mkdir -p '..data_dir .. 'lua')
--   end
-- 
--   if vim.fn.filereadable(compile_to_lua) == 1 then
--     os.remove(compile_to_lua)
--   end
-- 
--   local file = io.open(compile_to_lua,"w")
--   for _,line in ipairs(lines) do
--     file:write(line)
--   end
--   file:close()
-- 
--   os.remove(packer_compiled)
-- end
-- 
-- function plugins.magic_compile()
--   -- where define
--   -- packer.compile = function(raw_args, move_plugins)
--   plugins.compile()
--   plugins.convert_compile_file()
-- end
-- 
-- function plugins.auto_compile()
--   local file = vim.fn.expand('%:p')
--   if file:match(modules_dir) then
--     plugins.clean()
--     plugins.compile()
--     plugins.convert_compile_file()
--   end
-- end
-- 
-- function plugins.load_compile()
--   if vim.fn.filereadable(compile_to_lua) == 1 then
--     require('_compiled')
--   else
--     assert('Missing packer compile file Run PackerCompile Or PackerInstall to fix')
--   end
--   vim.cmd [[command! PackerCompile lua require('core.pack').magic_compile()]]
--   vim.cmd [[command! PackerInstall lua require('core.pack').install()]]
--   vim.cmd [[command! PackerUpdate lua require('core.pack').update()]]
--   vim.cmd [[command! PackerSync lua require('core.pack').sync()]]
--   vim.cmd [[command! PackerClean lua require('core.pack').clean()]]
--   vim.cmd [[autocmd User PackerComplete lua require('core.pack').magic_compile()]]
--   vim.cmd [[command! PackerStatus  lua require('packer').status()]]
-- end
-- 
-- return plugins
-- plugin api: pack api and load_compile and auto_compile and magic_compile 
-- function plugins.ensure_plugins()
-- function plugins.convert_compile_file()
-- how use 



local fn, uv, api = vim.fn, vim.loop, vim.api
local vim_path = require('core.global').vim_path
local data_dir = require('core.global').data_dir
local modules_dir = vim_path .. '/lua/modules'
local lazy_path = data_dir .. 'lazy/lazy.nvim'

-- Lazy manager module
local Lazy = {}
Lazy.__index = Lazy

function Lazy:load_plugins()
  self.repos = {}

  local get_plugins_list = function()
    local list = {}
    local tmp = vim.split(fn.globpath(modules_dir, '*/plugins.lua'), '\n')
    for _, f in ipairs(tmp) do
      list[#list + 1] = f:sub(#modules_dir - 6, -1)
    end
    return list
  end

  local plugins_file = get_plugins_list()
  for _, m in ipairs(plugins_file) do
    local repos = require(m:sub(0, #m - 4))
    for repo, conf in pairs(repos) do
      -- Convert packer config to lazy.nvim config format
      local plugin_spec = self:convert_plugin_format(repo, conf)
      self.repos[#self.repos + 1] = plugin_spec
    end
  end

  return self.repos
end

function Lazy:convert_plugin_format(repo, conf)
  -- Create base plugin spec for lazy.nvim
  local plugin_spec = {
    repo,  -- Will be the first element in the table
  }

  -- Handle common options between packer and lazy
  if conf.as then plugin_spec.name = conf.as end
  if conf.branch then plugin_spec.branch = conf.branch end
  if conf.commit then plugin_spec.commit = conf.commit end
  if conf.tag then plugin_spec.tag = conf.tag end
  if conf.event then plugin_spec.event = conf.event end
  if conf.ft then plugin_spec.ft = conf.ft end
  if conf.cmd then plugin_spec.cmd = conf.cmd end
  if conf.dependencies then plugin_spec.dependencies = conf.dependencies end
  if conf.after then plugin_spec.dependencies = conf.after end -- convert 'after' to dependencies
  if conf.config then plugin_spec.config = conf.config end

  -- Convert packer 'opt' to lazy 'lazy'
  if conf.opt ~= nil then
    plugin_spec.lazy = conf.opt
  end

  -- If there's a requires field in packer, convert to dependencies in lazy
  if conf.requires then
    -- Ensure dependencies is a table
    if plugin_spec.dependencies == nil then
      plugin_spec.dependencies = {}
    elseif type(plugin_spec.dependencies) ~= "table" then
      -- If dependencies is a string, convert it to a table
      plugin_spec.dependencies = {plugin_spec.dependencies}
    end

    -- Process the requires field
    local deps = type(conf.requires) == "table" and conf.requires or {conf.requires}
    for _, dep in ipairs(deps) do
      table.insert(plugin_spec.dependencies, dep)
    end
  end

  -- Convert hook functions if any
  if conf.setup then plugin_spec.init = conf.setup end

  -- Handle run commands
  if conf.run then plugin_spec.build = conf.run end

  return plugin_spec
end

function Lazy:init_ensure_lazy()
  local state = uv.fs_stat(lazy_path)
  if not state then
    print("Installing lazy.nvim...")
    fn.system({
      "git",
      "clone",
      "--filter=blob:none",
      "https://github.com/folke/lazy.nvim.git",
      "--branch=stable",
      lazy_path,
    })
  end

  vim.opt.rtp:prepend(lazy_path)
end

-- Public API for the lazy module
local plugins = {}

function plugins.ensure_plugins()
  local lazy_mgr = setmetatable({}, Lazy)
  lazy_mgr:init_ensure_lazy()
end

function plugins.load_plugins()
  local lazy_mgr = setmetatable({}, Lazy)
  return lazy_mgr:load_plugins()
end

function plugins.auto_compile()
  -- With lazy.nvim, explicit compilation is not needed
  -- Checking if current file is in modules directory
  local file = vim.fn.expand('%:p')
  if file:match(modules_dir) then
    -- Reload lazy to pick up changes
    require("lazy").sync()
  end
end

function plugins.load_compile()
  -- Initialize lazy.nvim
  local lazy_mgr = setmetatable({}, Lazy)
  lazy_mgr:init_ensure_lazy()

  -- Setup lazy.nvim with plugins
  require("lazy").setup(lazy_mgr:load_plugins(), {
    root = data_dir .. "lazy", -- directory where plugins will be installed
    defaults = {
      lazy = false, -- should plugins be lazy-loaded?
      version = nil,
    },
    lockfile = data_dir .. "lazy-lock.json", -- lockfile generated after running update
    concurrency = 16, -- maximum number of concurrent tasks
    git = {
      timeout = 120, -- git clone timeout
    },
    log = {
      level = "debug",
    },
    ui = {
      -- The border to use for the UI window. Accepts same border values as |nvim_open_win()|.
      border = "rounded",
    },
    performance = {
      -- Enable caching of compiled plugin specs
      cache = {
        enabled = true,
      },
      reset_packpath = true, -- reset the package path to improve startup time
      rtp = {
        reset = true, -- reset the runtime path to $VIMRUNTIME and your config directory
      },
    },
  })

  -- Setup commands - unlike packer, lazy has built-in commands, but we can create aliases for compatibility
  vim.cmd([[command! PackerCompile lua require("lazy").sync()]])
  vim.cmd([[command! PackerInstall lua require("lazy").install()]])
  vim.cmd([[command! PackerUpdate lua require("lazy").update()]])
  vim.cmd([[command! PackerSync lua require("lazy").sync()]])
  vim.cmd([[command! PackerClean lua require("lazy").clean()]])
  vim.cmd([[command! PackerStatus lua require("lazy").home()]])
end


-- Helper function to check if a plugin is loaded (replacement for packer_plugins)
function plugins.is_plugin_loaded(plugin_name)
  -- Using lazy.nvim API to check if plugin is loaded
  local lazy_config = require("lazy.core.config")
  local plugin_spec = lazy_config.plugins[plugin_name]
  if not plugin_spec then
    -- Try checking with a normalized name (e.g., 'nvim-telescope/telescope.nvim' -> 'telescope.nvim')
    local normalized_name = plugin_name:match(".*/(.*)")
    if normalized_name then
      plugin_spec = lazy_config.plugins[normalized_name]
    end
  end

  return plugin_spec and plugin_spec._.loaded
end

-- Function to get a plugin spec (alternative to packer_plugins table)
function plugins.get_plugin_spec(plugin_name)
  local lazy_config = require("lazy.core.config")
  local plugin_spec = lazy_config.plugins[plugin_name]

  if not plugin_spec then
    -- Try checking with a normalized name (e.g., 'nvim-telescope/telescope.nvim' -> 'telescope.nvim')
    local normalized_name = plugin_name:match(".*/(.*)")
    if normalized_name then
      plugin_spec = lazy_config.plugins[normalized_name]
    end
  end

  return plugin_spec
end



return plugins

