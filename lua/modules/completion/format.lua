local lsp = vim.lsp
local format = {}

-- local function nvim_create_augroup(group_name,definitions)
--   vim.api.nvim_command('augroup '..group_name)
--   vim.api.nvim_command('autocmd!')
--   for _, def in ipairs(definitions) do
--     local command = table.concat(vim.tbl_flatten{'autocmd', def}, ' ')
--     vim.api.nvim_command(command)
--   end
--   vim.api.nvim_command('augroup END')
-- end
-- 
-- function format.lsp_before_save()
--   local defs = {}
--   local ext = vim.fn.expand('%:e')
--   table.insert(defs,{"BufWritePre", '*.'..ext ,
--                     "lua vim.lsp.buf.formatting_sync(nil,1000)"})
-- --   if ext == 'go' then
-- --     table.insert(defs,{"BufWritePre","*.go",
-- --             "lua require('modules.completion.format').go_organize_imports_sync(1000)"})
-- --   end
--   nvim_create_augroup('lsp_before_save',defs)
-- end



function format.lsp_before_save()
  local ext = vim.fn.expand('%:e') -- get file extension
  local group = vim.api.nvim_create_augroup("LspFormatOnSave", { clear = true })

  vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*." .. ext,
    group = group,
    callback = function()
      vim.lsp.buf.format({ async = false }) -- sync formatting before save
    end,
    desc = "LSP format before save",
  })

  -- Optional: goimports for Go files
  if ext == "go" then
    vim.api.nvim_create_autocmd("BufWritePre", {
      pattern = "*.go",
      group = group,
      callback = function()
        require("conform").format({ async = false }) -- use true for async
    --    require("modules.completion.format").go_organize_imports_sync(1000)
      end,
      desc = "Organize Go imports before save",
    })
  end

-- 🔧 Format on save (sync)
--  vim.api.nvim_create_autocmd("BufWritePre", {
--    pattern = "*.go",
--    callback = function()
--      require("conform").format({ async = false }) -- use true for async
--    end,
--  })


end



-- Synchronously organise (Go) imports. Taken from
-- https://github.com/neovim/nvim-lsp/issues/115#issuecomment-654427197.
-- function format.go_organize_imports_sync(timeout_ms)
--   local context = { source = { organizeImports = true } }
--   -- vim.validate { context = { context, 't', true } }
--   local client = lsp.get_clients({ bufnr = 0 })[1]
--   local encoding = client and client.offset_encoding or "utf-16"
--   local params = vim.lsp.util.make_range_params(nil, { encoding = encoding })
-- 
--   -- local params = vim.lsp.util.make_range_params()
--   params.context = context
-- 
--   -- See the implementation of the textDocument/codeAction callback
--   -- (lua/vim/lsp/handler.lua) for how to do this properly.
--   local result = lsp.buf_request_sync(0, "textDocument/codeAction", params, timeout_ms)
--   if not result or next(result) == nil then return end
--   local actions = result[1].result or nil
--   if not actions then return end
--   local action = actions[1]
-- 
--   -- textDocument/codeAction can return either Command[] or CodeAction[]. If it
--   -- is a CodeAction, it can have either an edit, a command or both. Edits
--   -- should be executed first.
--   if action.edit or type(action.command) == "table" then
--     if action.edit then
--       vim.lsp.util.apply_workspace_edit(action.edit)
--     end
--     if type(action.command) == "table" then
--       vim.lsp.buf.execute_command(action.command)
--     end
--   else
--     vim.lsp.buf.execute_command(action)
--   end
-- end

return format
