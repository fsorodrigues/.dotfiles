return {
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl",
  config = function()
    vim.keymap.set(
      "n",
      "<leader>ibl",
      "<CMD>IBLToggle<CR>",
      { noremap = true, desc = "Toggle indentation lines" }
    )

    require("ibl").setup({
      enabled = false,
    })
  end,
}
