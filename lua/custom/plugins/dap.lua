-- NeuralNine Python DAP Source (that works!) https://github.com/NeuralNine/config-files/blob/master/.config/nvim/lua/plugins/nvim-dap.lua
-- TJ Devries Elixir Source https://github.com/tjdevries/config.nvim/blob/master/lua/custom/plugins/dap.lua

-- Main - https://github.com/mfussenegger/nvim-dap?tab=readme-ov-file
-- You'll need to install and configure a debug adapter per language
-- Side note - "go" already defined in kickstart.plugins.debug

return {
  {
    'mfussenegger/nvim-dap',
    dependencies = {
      -- DAP UI
      -- https://github.com/rcarriga/nvim-dap-ui?tab=readme-ov-file#installation
      -- Element actions - https://github.com/rcarriga/nvim-dap-ui?tab=readme-ov-file#installation
      'rcarriga/nvim-dap-ui',
      'nvim-neotest/nvim-nio',
      'theHamsta/nvim-dap-virtual-text', -- Assumes that I've already installed nvim-treesitter - https://github.com/theHamsta/nvim-dap-virtual-text?tab=readme-ov-file#nvim-dap-virtual-text

      -- PYTHON
      -- https://codeberg.org/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation#python
      -- nvim-dap-python comes wtih adapter and configurations definitions
      -- Installed 'debugpy' through Mason
      'mfussenegger/nvim-dap-python',

      -- LUA
      -- https://codeberg.org/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation#lua
      -- Installed 'local-lua-debugger-vscode' via Mason
    },
    config = function()
      local dap, dapui = require 'dap', require 'dapui'
      dapui.setup {}
      -- Options listed here - https://github.com/theHamsta/nvim-dap-virtual-text?tab=readme-ov-file#nvim-dap-virtual-text
      require('nvim-dap-virtual-text').setup {
        commented = false, -- prefix virtual text with comment string
      }
      -- PYTHON
      -- Installation steps from https://github.com/mfussenegger/nvim-dap-python
      require('dap-python').setup 'python3'
      -- If using the above, then `python3 -m debugpy --version`
      -- must work in the shell

      -- LUA
      --local lua_debugger_path = vim.fn.stdpath 'data' .. '/mason/packages/local-lua-debugger-vscode/'
      local lua_debugger_path = vim.fn.stdpath 'data' .. '/mason/share/local-lua-debugger-vscode/'
      -- Adapter source - nvim-dap wiki
      dap.adapters['local-lua'] = {
        type = 'executable',
        command = 'node',
        args = {
          -- IGNORE - NOTE - Mason is high and on crack (On my MacOS at least) - it adds an extra "extension" folder inside the extension folder
          --lua_debugger_path .. '/extension/extension/debugAdapter.js',
          lua_debugger_path .. '/extension/debugAdapter.js',
        },
        enrich_config = function(config, on_config)
          if not config['extensionPath'] then
            local c = vim.deepcopy(config)
            -- 💀 If this is missing or wrong you'll see
            -- "module 'lldebugger' not found" errors in the dap-repl when trying to launch a debug session
            -- IGNORE NOTE - Again, Mason is on crack and adds another "extension" folder. Need to provide path to the lowest level "extension" folder
            --c.extensionPath = lua_debugger_path .. 'extension'
            c.extensionPath = lua_debugger_path
            on_config(c)
          else
            on_config(config)
          end
        end,
      }
      -- Configurations block source - https://zignar.net/2023/06/10/debugging-lua-in-neovim/#debugging-lua
      dap.configurations.lua = {
        {
          name = 'Current file (local-lua-dbg, lua)',
          type = 'local-lua',
          request = 'launch',
          cwd = '${workspaceFolder}',
          program = {
            lua = 'lua',
            file = '${file}',
          },
          args = {},
        },
      }
      -- Many key maps defined in kickstart.plugins.debug (init.lua)
      -- F1 - Step Into
      -- F2 - Step Over
      -- F3 - Step Out
      -- F5 - Start/continue
      -- <leader>b/B - Toggle/set breakpoint
      -- F7 - Debug: See last session's result
      -- Here are the remaining keymaps
      vim.keymap.set('n', '<F4>', dap.step_back, { desc = 'Step back' })
      vim.keymap.set('n', '<F6>', dap.restart, { desc = 'Debug: Restart' })
      --vim.keymap.set('n', '<F8>', dap.stop, { desc = 'Debug: Stop' })
      vim.keymap.set('n', '<F8>', dap.terminate, { desc = 'Debug: Stop' })
      vim.keymap.set('n', '<F10>', dap.run_last, { desc = 'Debug: Re-run last configuration' })

      -- Redefine signs
      vim.fn.sign_define('DapBreakpoint', {
        text = '',
        texthl = 'DiagnosticSignError',
        linehl = '',
        numhl = '',
      })

      vim.fn.sign_define('DapBreakpointRejected', {
        text = '', -- or "❌"
        texthl = 'DiagnosticSignError',
        linehl = '',
        numhl = '',
      })

      vim.fn.sign_define('DapStopped', {
        text = '', -- or "→"
        texthl = 'DiagnosticSignWarn',
        linehl = 'Visual',
        numhl = 'DiagnosticSignWarn',
      })

      -- You can use nvim-dap events to open and close the windows automatically (:help dap-extensions)
      dap.listeners.before.attach.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.launch.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated.dapui_config = function()
        dapui.close()
      end
      dap.listeners.before.event_exited.dapui_config = function()
        dapui.close()
      end
    end,
  },
}
