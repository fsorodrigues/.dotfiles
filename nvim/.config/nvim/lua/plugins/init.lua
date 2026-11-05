return {
  "nvim-lua/plenary.nvim", -- lua functions that many plugins use
  {
    "christoomey/vim-tmux-navigator",
    enabled = vim.env.TMUX ~= nil and vim.env.TMUX ~= "",
  }, -- tmux & split window navigation
  {
    "baggiponte/rex-navigator.nvim",
    main = "rex-navigator",
    lazy = false,
    opts = {},
  }, -- rex & split window navigation
}
