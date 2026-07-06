return {
  {
    "folke/tokyonight.nvim",
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      -- load the colorscheme here
      vim.cmd([[colorscheme tokyonight-storm]])
      vim.cmd("hi Whitespace guifg=#a9b1d6")
      vim.cmd("hi NonText guibg=#3b4261 guifg=#a9b1d6")
    end,
  },
}
