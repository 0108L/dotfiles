if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

local prefix = "<Leader>fd"

return {
  {
    -- NOTE: better quickfix
    "kevinhwang91/nvim-bqf",
    ft = "qf",
    dependencies = {
      "AstroNvim/astrocore",
      ---@param opts AstroCoreOpts
      opts = function(_, opts)
        if not opts.signs then opts.signs = {} end
        opts.signs.BqfSign = { text = " " .. require("astroui").get_icon "Selected", texthl = "BqfSign" }
      end,
    },
    opts = {},
  },
  { -- NOTE: highlight dap
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      "LiadOz/nvim-dap-repl-highlights",
      dependencies = { "mfussenegger/nvim-dap" },
      opts = {},
    },
    opts = function(_, opts)
      if opts.ensure_installed ~= "all" then
        opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, { "dap_repl" })
      end
    end,
  },
  { -- NOTE: make dap virtual text
    "theHamsta/nvim-dap-virtual-text",
    dependencies = { "mfussenegger/nvim-dap", "nvim-treesitter/nvim-treesitter" },
    event = "User AstroFile",
    opts = {
      commented = true,
      enabled = true,
      enabled_commands = true,
    },
  },
  { -- NOTE: add persistent breakpoints for dap
    "Weissle/persistent-breakpoints.nvim",
    event = "BufReadPost",
    opts = function(_, opts)
      return require("astrocore").extend_tbl(opts, {
        load_breakpoints_event = { "BufReadPost" },
      })
    end,
    keys = {
      {
        "<Leader>db",
        function() require("persistent-breakpoints.api").toggle_breakpoint() end,
        { silent = true },
        desc = "Toggle Breakpoint",
      },
      {
        "<Leader>dB",
        function() require("persistent-breakpoints.api").clear_all_breakpoints() end,
        { silent = true },
        desc = "Clear Breakpoints",
      },
      {
        "<Leader>dC",
        function() require("persistent-breakpoints.api").set_conditional_breakpoint() end,
        { silent = true },
        desc = "Conditional Breakpoint",
      },
    },
  },
  { -- NOTE: telescope dap
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-telescope/telescope-dap.nvim",
      {
        "AstroNvim/astrocore",
        opts = {
          mappings = {
            n = {
              [prefix .. "c"] = {
                "<Cmd>lua require('telescope').extensions.dap.commands()<CR>",
                desc = "Telescope DAP commands",
              },
              [prefix .. "f"] = {
                "<Cmd>lua require('telescope').extensions.dap.frames()<CR>",
                desc = "Telescope DAP frames",
              },
              [prefix .. "g"] = {
                "<Cmd>lua require('telescope').extensions.dap.configurations()<CR>",
                desc = "Telescope DAP configurations",
              },
              [prefix .. "l"] = {
                "<Cmd>lua require('telescope').extensions.dap.list_breakpoints()<CR>",
                desc = "Telescope DAP list breakpoints",
              },
              [prefix .. "v"] = {
                "<Cmd>lua require('telescope').extensions.dap.variables()<CR>",
                desc = "Telescope DAP variables",
              },
            },
          },
        },
      },
    },
    opts = function() require("telescope").load_extension "dap" end,
  },
}
