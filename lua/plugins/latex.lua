return {
  "lervag/vimtex",
  ft = { "tex", "bib" },
  init = function()
    -- ============================================================================
    -- VIEWER
    -- ============================================================================
    vim.g.vimtex_view_method = "zathura"
    vim.g.vimtex_view_automatic = 0  -- No abrir auto, usamos keymap

    -- ============================================================================
    -- COMPILER
    -- ============================================================================
    vim.g.vimtex_compiler_method = "latexmk"
    vim.g.vimtex_compiler_latexmk = {
      build_dir = "",  -- Vacío = mismo directorio que el .tex
      options = {
        "-pdf",
        "-interaction=nonstopmode",
        "-synctex=1",
        "-file-line-error",
      },
    }

    -- Compilación continua en background (como Overleaf)
    -- Cambia a 0 si prefieres compilar manualmente
    vim.g.vimtex_compiler_latexmk_engines = {
      _ = "-pdf",
    }

    -- ============================================================================
    -- SYNTAX HIGHLIGHTING (lo hace VimTeX, no TreeSitter)
    -- ============================================================================
    vim.g.vimtex_syntax_enabled = 1  -- Habilitar (tu config lo deshabilitaba)
    vim.g.vimtex_syntax_conceal_disable = 0  -- Conceal para símbolos matemáticos

    -- ============================================================================
    -- DESHABILITAR LO QUE NO QUERÉS
    -- ============================================================================
    vim.g.vimtex_fold_enabled = 0  -- Sin folding
    vim.g.vimtex_imaps_enabled = 0  -- Sin insert mode maps automáticos
    vim.g.vimtex_indent_enabled = 0  -- Dejar que Neovim maneje indent

    -- Deshabilitar mappings default, usamos explícitos
    vim.g.vimtex_mappings_enabled = 0

    -- ============================================================================
    -- QUICKFIX: SOLO ERRORES RELEVANTES
    -- ============================================================================
    vim.g.vimtex_quickfix_enabled = 1
    vim.g.vimtex_quickfix_mode = 2  -- Auto-abrir si hay errores
    vim.g.vimtex_quickfix_open_on_warning = 0

    -- Filtrar warnings irrelevantes
    vim.g.vimtex_quickfix_ignore_filters = {
      "Underfull",
      "Overfull",
      "specifier changed to",
      "Token not allowed in a PDF string",
    }

    -- ============================================================================
    -- TOC (TABLA DE CONTENIDOS / NAVEGACIÓN)
    -- ============================================================================
    vim.g.vimtex_toc_config = {
      name = "Secciones",
      layers = { "content", "todo", "include" },
      split_width = 35,
      todo_sorted = 0,
      show_help = 0,
      show_numbers = 1,
    }

    -- ============================================================================
    -- PERFORMANCE: PROYECTOS GRANDES
    -- ============================================================================
    vim.g.vimtex_parser_bib_backend = "bibtex"  -- Más rápido que biblatex
    vim.g.vimtex_cache_root = vim.fn.stdpath("cache") .. "/vimtex"

    -- ============================================================================
    -- COMPLETION: Dejar que texlab maneje esto vía LSP
    -- ============================================================================
    vim.g.vimtex_complete_enabled = 0
  end,

  config = function()
    -- ============================================================================
    -- KEYMAPS EXPLÍCITOS
    -- ============================================================================
    -- Compilación
    vim.keymap.set("n", "<leader>lc", "<cmd>VimtexCompile<cr>",
      { desc = "Toggle compilación continua" })
    vim.keymap.set("n", "<leader>lk", "<cmd>VimtexStop<cr>",
      { desc = "Detener compilación" })
    vim.keymap.set("n", "<leader>ll", "<cmd>VimtexCompileSS<cr>",
      { desc = "Compilar una vez (single shot)" })

    -- Visualización
    vim.keymap.set("n", "<leader>lv", "<cmd>VimtexView<cr>",
      { desc = "Ver PDF" })

    -- Errores
    vim.keymap.set("n", "<leader>le", "<cmd>VimtexErrors<cr>",
      { desc = "Ver errores" })

    -- Navegación
    vim.keymap.set("n", "<leader>lt", "<cmd>VimtexTocToggle<cr>",
      { desc = "Toggle TOC/Secciones" })

    -- Limpieza
    vim.keymap.set("n", "<leader>lx", "<cmd>VimtexClean<cr>",
      { desc = "Limpiar archivos auxiliares" })
    vim.keymap.set("n", "<leader>lX", "<cmd>VimtexClean!<cr>",
      { desc = "Limpiar todo (incluye PDF)" })

    -- Info del proyecto
    vim.keymap.set("n", "<leader>li", "<cmd>VimtexInfo<cr>",
      { desc = "Info del proyecto LaTeX" })

    -- ============================================================================
    -- AUTOCOMMANDS
    -- ============================================================================
    local augroup = vim.api.nvim_create_augroup("VimTeX_Custom", { clear = true })

    -- Iniciar compilación continua al abrir .tex
    vim.api.nvim_create_autocmd("FileType", {
      group = augroup,
      pattern = "tex",
      callback = function()
        -- Descomentar si querés compilación auto al abrir:
        -- vim.cmd("VimtexCompile")
      end,
    })

    -- Cerrar viewer al cerrar Neovim
    vim.api.nvim_create_autocmd("VimLeave", {
      group = augroup,
      pattern = "*.tex",
      callback = function()
        vim.cmd("VimtexClean")
      end,
    })
  end,
}
