return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      filesystem = {
        filtered_items = {
          hide_dotfiles = false,
        },
      },
    },
  },
  -- highligh the same code block
  -- {
  --   "RRethy/vim-illuminate",
  --   event = "User AstroFile",
  --   opts = {},
  --   config = function(_, opts) require("illuminate").configure(opts) end,
  -- },
  -- {
  --   "catppuccin",
  --   optional = true,
  --   ---@type CatppuccinOptions
  --   opts = { integrations = { illuminate = true } },
  -- },
  {
    "akinsho/toggleterm.nvim",
    opts = {
      shell = "/usr/bin/fish",
    },
  },
  -------------------------------
}
