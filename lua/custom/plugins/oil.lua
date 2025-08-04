-- Source https://github.com/tjdevries/config.nvim/blob/master/lua/custom/plugins/oil.lua
-- https://github.com/stevearc/oil.nvim?tab=readme-ov-file#installation

-- Shortcuts list - g?
-- NOTE: oil.nvim turns off netrw by default
return {
  {
    -- :help Oil
    'stevearc/oil.nvim',
    ---@module 'oil'
    ---@type oil.SetupOpts
    -- Optional dependencies
    dependencies = { { 'echasnovski/mini.icons', opts = {} } },
    -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
    -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
    lazy = false,
    -- config = function()
    --   require('oil').setup {
    --     view_options = {
    --       -- Show files and directories that start with "."
    --       show_hidden = true,
    --     },
    --     vim.keymap.set('n', '-', '<CMD>Oil --float<CR>', { desc = 'Open parent directory' }),
    --   }
    -- end,
    opts = {
      delete_to_trash = true, -- NOTE: On Mac - give full disk access to terminal emulator to write to .Trash dir
      skip_confirm_for_simple_edits = true,
      view_options = {
        -- Show files and directories that start with "."
        show_hidden = true,
      },
      vim.keymap.set('n', '-', '<CMD>Oil --float<CR>', { desc = 'Open parent directory' }),
    },
  },
}
