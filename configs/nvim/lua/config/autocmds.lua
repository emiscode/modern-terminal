-- Neovim autocommands

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- Highlight on yank
local yank_group = augroup("YankHighlight", { clear = true })
autocmd("TextYankPost", {
  group = yank_group,
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Format on save (optional, can be disabled)
local format_group = augroup("FormatOnSave", { clear = true })
autocmd("BufWritePre", {
  group = format_group,
  pattern = { "*.lua", "*.js", "*.ts", "*.jsx", "*.tsx", "*.py" },
  callback = function()
    vim.lsp.buf.format { async = false }
  end,
})

