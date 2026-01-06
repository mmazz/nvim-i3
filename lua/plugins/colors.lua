function ColorMyPencils(color)
    --color = color or "tokyonight"
    color = color or "gruvbox"
    vim.cmd.colorscheme(color)

    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })

    vim.api.nvim_set_hl(0, 'LineNrAbove', { fg='#b0b7c0' })
    vim.api.nvim_set_hl(0, 'LineNr', { fg='#647c90' })
    vim.api.nvim_set_hl(0, 'LineNrBelow', { fg='#b0b7c0' })
end

-- color
return {
    {
        'norcalli/nvim-colorizer.lua',
        config = function()
            require("colorizer").setup()
        end
    },
    {
        "folke/tokyonight.nvim",
        config = function()
            require("tokyonight").setup({
                style = "storm",
                transparent = true,
                terminal_colors = true,
                styles = {
                    comments = { italic = false },
                    keywords = { italic = false },
                    sidebars = "dark",
                    floats = "dark",
                },
                on_highlights = function(hl, c)
                  hl.DiagnosticUnnecessary = {
                    fg = c.comment,
                  }
                end,
            })
            --ColorMyPencils("tokyonight")
        end
    },
    {
        "ellisonleao/gruvbox.nvim",
        config = function()
            require("gruvbox").setup({

            })
            --ColorMyPencils("gruvbox")
        end


    },
    {
        "catppuccin/nvim",
        config = function()
            require("catppuccin").setup({
                flavour = "frappe",
            })
 --           ColorMyPencils()
        end
    },
    {
        'arcticicestudio/nord-vim',
        config = function()
            ColorMyPencils("nord")
        end


    },
}

