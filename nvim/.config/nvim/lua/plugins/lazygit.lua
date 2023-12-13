return {
  "kdheepak/lazygit.nvim",
  -- optional for floating window border decoration
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  keys = { {
    "<leader>gg",
    "<cmd>LazyGit<cr>",
    desc = "Start LazyGit panel",
  } },
  config = function()
    -- set local ref
    local g = vim.g
    g.lazygit_floating_window_winblend = 0 -- transparency of floating window
    g.lazygit_floating_window_scaling_factor = 1 -- scaling factor for floating window
    g.lazygit_use_custom_config_file_path = 1 -- config file path is evaluated if this value is 1
    g.lazygit_config_file_path = "/Users/fsorodrigues/.config/lazygit/config.yml" -- custom config file path
  end,
}
