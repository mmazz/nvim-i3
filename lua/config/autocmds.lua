local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local mmazzGroup = augroup("mmazz", { clear = true })


local yank_group = augroup('HighlightYank', {})

-- Para recargar un modulo lua, por si lo estoy modificando o algo
-- por ahora no lo uso.
local function R(name)
  package.loaded[name] = nil
  require(name)
end

autocmd('TextYankPost', {
    group = yank_group,
    pattern = '*',
    callback = function()
        vim.highlight.on_yank({
            higroup = 'IncSearch',
            timeout = 150,
        })
    end,
})


autocmd("BufWritePre", {
  group = mmazzGroup,
  callback = function()
    local pos = vim.fn.getpos(".")
    vim.cmd([[%s/\s\+$//e]])
    vim.fn.setpos(".", pos)
  end,
})

autocmd("LspAttach", {
  group = mmazzGroup,
  callback = function(ev)
    local opts = { buffer = ev.buf }

    -- Navigation
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)

    -- Diagnostics
    vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
    vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)

    -- Hover
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)

    -- Symbols (⚠️ PLURAL)
 --   vim.keymap.set("n", "<leader>ls", vim.lsp.buf.document_symbols, opts)
  --  vim.keymap.set("n", "<leader>ws", vim.lsp.buf.workspace_symbols, opts)

    -- Actions
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
  end,
})


autocmd("FileType", {
  group = mmazzGroup,
  pattern = { "tex", "markdown", "pandoc" },
  callback = function()
    vim.opt_local.spell = true
    vim.opt_local.spelllang = { "es", "en_us" }
    vim.opt_local.textwidth = 80
    vim.opt_local.wrap = true
    vim.opt_local.linebreak = true
  end,
})


