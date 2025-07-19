-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
--
-- NOTE: Use this file to add plugins with minimal to no configuration setup. If it needs config setup, move it to a separate file

return {
  { -- Set default path as project root for telescope, etc
    'ahmedkhalf/project.nvim', -- https://github.com/ahmedkhalf/project.nvim
    config = function()
      require('project_nvim').setup {}
    end,
  },
  {
    'MeanderingProgrammer/render-markdown.nvim', -- https://github.com/MeanderingProgrammer/render-markdown.nvim?tab=readme-ov-file#render-markdownnvim
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' }, -- if you use the mini.nvim suite
    opts = { completions = { blink = { enabled = true } } },
  },
}
