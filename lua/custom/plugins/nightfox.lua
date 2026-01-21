return {
  { -- You can easily change to a different colorscheme.
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
              deutan = 0.9,
              tritan = 0,
            },
          },
        },
      }

      vim.cmd.colorscheme 'nightfox'
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et
