return {
  "stevearc/oil.nvim",
  dependencies = { { "echasnovski/mini.icons", opts = {} } },
  lazy = false,
  opts = {
    view_options = {
      show_hidden = true,
    },
    float = {
      padding = 2,
      max_width = 0.8,
      max_height = 0.8,
      border = "rounded",
    },
    default_file_explorer = true,
    keymaps = {
      ["<C-l>"] = false,
      ["<C-r>"] = "actions.refresh",
    }
  },
  config = function(_, opts)
    vim.keymap.set("n", "<leader>ee", "<CMD>Oil --float<CR>", { desc = "Toggle Oil file navigator" })
    require("oil").setup(opts)
  end
}
