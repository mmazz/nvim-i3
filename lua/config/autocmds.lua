local augroup = vim.api.nvim_create_augroup
local mmazzGroup = augroup('mmazz', {})

local autocmd = vim.api.nvim_create_autocmd
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
autocmd('LspAttach', {
    group = mmazzGroup,
    callback = function(ev)
        local opts = { buffer = ev.buf }
        vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
        -- vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
        -- vim.keymap.set("n", 'gi', vim.lsp.buf.implementation, opts)
        --
        --
        vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
        vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
        vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
        vim.keymap.set("n", "<leader>ls", function() vim.lsp.buf.document_symbol() end, opts)
        vim.keymap.set("n", "<leader>ws", function() vim.lsp.buf.workspace_symbol() end, opts)
        --vim.keymap.set("n", "<leader>d", function() vim.diagnostic.open_float() end, opts)
        vim.keymap.set("n", "<leader>ca", function() vim.lsp.buf.code_action() end, opts)
        vim.keymap.set("n", "gr", function() vim.lsp.buf.references() end, opts)
        vim.keymap.set("n", "<leader>rn", function() vim.lsp.buf.rename() end, opts)
 --       vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
    end
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


