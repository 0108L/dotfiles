return {
  --NOTE: fittencode
  {
    "luozhiya/fittencode.nvim",
    -- enable = false,
    event = "User AstroFile",
    opts = {
      keymaps = {
        inline = {
          ["<A-g>"] = "accept_all_suggestions",
          ["<A-j>"] = "accept_line",
          ["<A-l>"] = "accept_word",
          ["<A-k>"] = "revoke_line",
          ["<A-h>"] = "revoke_word",
          ["<A-;>"] = "triggering_completion",
        },
        -- NOTE:
        -- chat = {
        --   ["q"] = "close",
        --   ["[c"] = "goto_previous_conversation",
        --   ["]c"] = "goto_next_conversation",
        --   ["c"] = "copy_conversation",
        --   ["C"] = "copy_all_conversations",
        --   ["d"] = "delete_conversation",
        --   ["D"] = "delete_all_conversations",
        -- },
      },
    },
    dependencies = {
      "AstroNvim/astrocore",
      opts = {
        mappings = {
          n = {
            ["<A-c>"] = {
              "<Cmd>Fitten start_chat<CR>",
              desc = " Fitten Chat",
            },
          },
          i = {
            ["<A-c>"] = {
              "<Cmd>Fitten start_chat<CR>",
              desc = " Fitten Chat",
            },
          },
        },
      },
    },
  },
  --NOTE: codeium
  {
    "Exafunction/codeium.vim",
    enable = false,
    event = "User AstroFile",
    config = function()
      vim.keymap.set("i", "<C-g>", function() return vim.fn["codeium#Accept"]() end, { expr = true })
      vim.keymap.set("i", "<c-.>", function() return vim.fn["codeium#CycleCompletions"](1) end, { expr = true })
      vim.keymap.set("i", "<c-,>", function() return vim.fn["codeium#CycleCompletions"](-1) end, { expr = true })
      vim.keymap.set("i", "<c-x>", function() return vim.fn["codeium#Clear"]() end, { expr = true })
      vim.keymap.set("n", "<Leader>;", function()
        if vim.g.codeium_enabled == true then
          vim.cmd "CodeiumDisable"
        else
          vim.cmd "CodeiumEnable"
        end
      end, { noremap = true, desc = "Toggle Codeium active" })
    end,
  },
  -- HACK: not for me
  -- {
  --   "Exafunction/codeium.nvim",
  --   opts = {
  --     enable_chat = true,
  --   },
  --   dependencies = {
  --     "AstroNvim/astrocore",
  --     ---@param opts AstroCoreOpts
  --     opts = {
  --       mappings = {
  --         n = {
  --           ["<Leader>;"] = {
  --             name = " Codeium",
  --           },
  --           ["<Leader>;o"] = {
  --             desc = "Open Chat",
  --             function() vim.cmd "Codeium Chat" end,
  --           },
  --         },
  --       },
  --     },
  --   },
  -- },
  -- {
  --   "hrsh7th/nvim-cmp",
  --   optional = true,
  --   dependencies = { "Exafunction/codeium.nvim" },
  --   opts = function(_, opts)
  --     -- Inject codeium into cmp sources, with high priority
  --     table.insert(opts.sources, 1, {
  --       name = "codeium",
  --       group_index = 1,
  --       priority = 10000,
  --     })
  --   end,
  -- },
  -- {
  --   "onsails/lspkind.nvim",
  --   optional = true,
  --   -- Adds icon for codeium using lspkind
  --   opts = function(_, opts) opts.symbol_map = { Codeium = "" } end,
  -- },
}
