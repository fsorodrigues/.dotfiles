return {
  "fsorodrigues/present.nvim",
  -- dir = "~/projects/present.nvim",
  ft = { "markdown", "txt" },
  config = function()
    vim.keymap.set(
      "n",
      "<leader><leader>p",
      "<cmd>PresentStart<CR>",
      { desc = "Start presenting markdown document" }
    )
  end,
}
