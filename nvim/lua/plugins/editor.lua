return {
  -- NOTE: vimtex
  {
    "lervag/vimtex",
    lazy = false,
    dependencies = {
      "AstroNvim/astrocore",
      opts = {
        autocmds = {
          vimtex_mapping_descriptions = {
            {
              event = "FileType",
              desc = "Set up VimTex Which-Key descriptions",
              pattern = "tex",
              callback = function(event)
                local wk_avail, wk = pcall(require, "which-key")
                if not wk_avail then return end
                wk.add {
                  buffer = event.buf,
                  {
                    mode = "n",
                    { "<localleader>l", group = "VimTeX" },
                    { "<localleader>la", desc = "Show Context Menu" },
                    { "<localleader>lC", desc = "Full Clean" },
                    { "<localleader>lc", desc = "Clean" },
                    { "<localleader>le", desc = "Show Errors" },
                    { "<localleader>lG", desc = "Show Status for All" },
                    { "<localleader>lg", desc = "Show Status" },
                    { "<localleader>li", desc = "Show Info" },
                    { "<localleader>lI", desc = "Show Full Info" },
                    { "<localleader>lk", desc = "Stop VimTeX" },
                    { "<localleader>lK", desc = "Stop All VimTeX" },
                    { "<localleader>lL", desc = "Compile Selection" },
                    { "<localleader>ll", desc = "Compile" },
                    { "<localleader>lm", desc = "Show Imaps" },
                    { "<localleader>lo", desc = "Show Compiler Output" },
                    { "<localleader>lq", desc = "Show VimTeX Log" },
                    { "<localleader>ls", desc = "Toggle Main" },
                    { "<localleader>lt", desc = "Open Table of Contents" },
                    { "<localleader>lT", desc = "Toggle Table of Contents" },
                    { "<localleader>lv", desc = "View Compiled Document" },
                    { "<localleader>lX", desc = "Reload VimTeX State" },
                    { "<localleader>lx", desc = "Reload VimTeX" },
                    { "ts", group = "VimTeX Toggles & Cycles" },
                    { "ts$", desc = "Cycle inline, display & numbered equation" },
                    { "tsc", desc = "Toggle star of command" },
                    { "tsd", desc = "Cycle (), \\left(\\right) [,...]" },
                    { "tsD", desc = "Reverse Cycle (), \\left(\\right) [, ...]" },
                    { "tse", desc = "Toggle star of environment" },
                    { "tsf", desc = "Toggle a/b vs \\frac{a}{b}" },
                    { "[/", desc = "Previous start of a LaTeX comment" },
                    { "[*", desc = "Previous end of a LaTeX comment" },
                    { "[[", desc = "Previous beginning of a section" },
                    { "[]", desc = "Previous end of a section" },
                    { "[m", desc = "Previous \\begin" },
                    { "[M", desc = "Previous \\end" },
                    { "[n", desc = "Previous start of a math zone" },
                    { "[N", desc = "Previous end of a math zone" },
                    { "[r", desc = "Previous \\begin{frame}" },
                    { "[R", desc = "Previous \\end{frame}" },
                    { "]/", desc = "Next start of a LaTeX comment %" },
                    { "]*", desc = "Next end of a LaTeX comment %" },
                    { "][", desc = "Next beginning of a section" },
                    { "]]", desc = "Next end of a section" },
                    { "]m", desc = "Next \\begin" },
                    { "]M", desc = "Next \\end" },
                    { "]n", desc = "Next start of a math zone" },
                    { "]N", desc = "Next end of a math zone" },
                    { "]r", desc = "Next \\begin{frame}" },
                    { "]R", desc = "Next \\end{frame}" },
                    { "csc", desc = "Change surrounding command" },
                    { "cse", desc = "Change surrounding environment" },
                    { "cs$", desc = "Change surrounding math zone" },
                    { "csd", desc = "Change surrounding delimiter" },
                    { "dsc", desc = "Delete surrounding command" },
                    { "dse", desc = "Delete surrounding environment" },
                    { "ds$", desc = "Delete surrounding math zone" },
                    { "dsd", desc = "Delete surrounding delimiter" },
                  },
                  {
                    mode = "o",
                    { "ic", desc = "LaTeX Command" },
                    { "ac", desc = "LaTeX Command" },
                    { "id", desc = "LaTeX Math Delimiter" },
                    { "ad", desc = "LaTeX Math Delimiter" },
                    { "ie", desc = "LaTeX Environment" },
                    { "ae", desc = "LaTeX Environment" },
                    { "i$", desc = "LaTeX Math Zone" },
                    { "a$", desc = "LaTeX Math Zone" },
                    { "iP", desc = "LaTeX Section, Paragraph, ..." },
                    { "aP", desc = "LaTeX Section, Paragraph, ..." },
                    { "im", desc = "LaTeX Item" },
                    { "am", desc = "LaTeX Item" },
                  },
                }
              end,
            },
          },
        },
      },
    },
  },
  --NOTE: neorg
  {
    "nvim-neorg/neorg",
    version = "^8",
    event = "VeryLazy",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      {
        "AstroNvim/astrocore",
        opts = {
          mappings = {
            n = {
              ["<localleader>i"] = { desc = "Date" },
              ["<localleader>l"] = { desc = "List" },
              ["<localleader>m"] = { desc = "Mode" },
              ["<localleader>n"] = { desc = "Note" },
              ["<localleader>t"] = { desc = "Mark" },
              ["<localleader><localleader>"] = { desc = "Neorg Command" },
              ["<localleader><localleader>j"] = {
                "<Cmd>Neorg journal<CR>",
                desc = "journal",
              },
              ["<localleader><localleader>c"] = {
                "<Cmd>Neorg toggle-concealer<CR>",
                desc = "toggle concealer",
              },
              ["<localleader><localleader>t"] = {
                "<Cmd>Neorg toc<CR>",
                desc = "toc",
              },
              ["<localleader><localleader>i"] = {
                "<Cmd>Neorg index<CR>",
                desc = "index",
              },
              ["<localleader><localleader>a"] = {
                "<Cmd>Neorg tangle<CR>",
                desc = "tangle",
              },
            },
          },
        },
      },
      {
        "vhyrro/luarocks.nvim",
        priority = 1000, -- Very high priority is required, luarocks.nvim should run as the first plugin in your config.
        config = true,
      },
    },
    opts = {
      load = {
        ["core.defaults"] = {}, -- Loads default behaviour
        ["core.concealer"] = {}, -- Adds pretty icons to your documents
        ["core.keybinds"] = {}, -- Adds default keybindings
        ["core.completion"] = {
          config = {
            engine = "nvim-cmp",
          },
        }, -- Enables support for completion plugins
        ["core.journal"] = {}, -- Enables support for the journal module
        ["core.dirman"] = { -- Manages Neorg workspaces
          config = {
            workspaces = {
              notes = "~/Documents/myDraft/norg",
            },
            default_workspace = "notes",
          },
        },
      },
    },
  },
  --NOTE: recorder
  {
    "chrisgrieser/nvim-recorder",
    dependencies = {
      { "rcarriga/nvim-notify" },
      { -- NOTE: to add whichkey descriptions
        "AstroNvim/astrocore",
        ---@param opts AstroCoreOpts
        opts = {
          mappings = {
            n = {
              ["<Leader>r"] = {
                name = " recorder",
              }, -- NOTE: add prefix without any keybindings
            },
          },
        },
      },
    },
    opts = {
      -- WARNING: the structure is the same as default
      slots = { "a", "s", "d", "f" },
      mapping = {
        startStopRecording = "q",
        playMacro = "Q",
        switchSlot = "<C-q>",
        editMacro = "<leader>re",
        deleteAllMacros = "<leader>rd",
        yankMacro = "<leader>ry",
        -- ⚠️ this should be a string you don't use in insert mode during a macro
        -- Breakpoints are automatically ignored when you trigger the macro with a count.
        addBreakPoint = "<leader>rr",
      },

      -- Clears all macros-slots on startup.
      clear = false,

      -- Log level used for non-critical notifications; mostly relevant for nvim-notify.
      -- (Note that by default, nvim-notify does not show the levels `trace` & `debug`.)
      logLevel = vim.log.levels.INFO, -- :help vim.log.levels

      -- If enabled, only essential notifications are sent.
      -- If you do not use a plugin like nvim-notify, set this to `true`
      -- to remove otherwise annoying messages.
      lessNotifications = false,

      -- Use nerdfont icons in the status bar components and keymap descriptions
      useNerdfontIcons = true,

      -- Performance optimzations for macros with high count. When `playMacro` is
      -- triggered with a count higher than the threshold, nvim-recorder
      -- temporarily changes changes some settings for the duration of the macro.
      performanceOpts = {
        countThreshold = 100,
        lazyredraw = true, -- enable lazyredraw (see `:h lazyredraw`)
        noSystemClipboard = true, -- remove `+`/`*` from clipboard option
        autocmdEventsIgnore = { -- temporarily ignore these autocmd events
          "TextChangedI",
          "TextChanged",
          "InsertLeave",
          "InsertEnter",
          "InsertCharPre",
        },
      },

      -- [experimental] partially share keymaps with nvim-dap.
      -- (See README for further explanations.)
      dapSharedKeymaps = false,
    },
  },
}
