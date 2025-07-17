return {
  { -- You can easily change to a different colorscheme.
    -- Change the name of the colorscheme plugin below, and then
    -- change the command in the config to whatever the name of that colorscheme is.
    --
    -- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
    'EdenEast/nightfox.nvim',
    priority = 1000, -- Make sure to load this before all the other start plugins.
    config = function()
      ---@diagnostic disable-next-line: missing-fields
      require('nightfox').setup {
        styles = {
          comments = { italic = false }, -- Disable italics in comments
        },
        options = {
          colorblind = {
            enable = true,
            simulate_only = false,
            severity = {
              protan = 0.3,
              deutan = 1.0,
              tritan = 0.1,
            },
          },
        },
      }

      -- Load the colorscheme here.
      -- Like many other themes, this one has different styles, and you could load
      -- any other, such as 'tokyonight-storm', 'tokyonight-moon', or 'tokyonight-day'.
      vim.cmd.colorscheme 'carbonfox'
    end,
  },
}
