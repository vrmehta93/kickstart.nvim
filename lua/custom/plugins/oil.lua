-- Source https://github.com/tjdevries/config.nvim/blob/master/lua/custom/plugins/oil.lua
-- https://github.com/stevearc/oil.nvim?tab=readme-ov-file#installation

return {
  {
    'stevearc/oil.nvim',
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {},
    -- Optional dependencies
    dependencies = { { 'echasnovski/mini.icons', opts = {} } },
    -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
    -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
    lazy = false,
    config = function()
      require('oil').setup {
        vim.keymap.set('n', '-', '<CMD>Oil --float<CR>', { desc = 'Open parent directory' }),
      }
    end,
  },
}
