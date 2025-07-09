-- https://github.com/folke/snacks.nvim
return {
  {
    'folke/snacks.nvim',
    priority = 1000,
    lazy = false,
    opts = {
      bigfile = {}, -- https://github.com/folke/snacks.nvim/blob/main/docs/bigfile.md
      bufdelete = {}, -- https://github.com/folke/snacks.nvim/blob/main/docs/bufdelete.md
      gitbrowse = {}, -- https://github.com/folke/snacks.nvim/blob/main/docs/gitbrowse.md
      input = {}, -- https://github.com/folke/snacks.nvim/blob/main/docs/input.md
    },
    keys = {
      {
        '<leader>bd',
        function()
          Snacks.bufdelete()
        end,
        desc = 'Buffer delete',
        mode = 'n',
      },
      {
        '<leader>ba',
        function()
          Snacks.bufdelete.all()
        end,
        desc = 'Buffer delete all',
        mode = 'n',
      },
      {
        '<leader>bo',
        function()
          Snacks.bufdelete.other()
        end,
        desc = 'Buffer delete other',
        mode = 'n',
      },
    },
  },
}
