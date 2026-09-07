vim.keymap.set("n", "<leader>l", "ciw[]()<Esc>F]Pf(a", {
  buffer = true,
  desc = "Create markdown link from word",
})

vim.keymap.set("x", "<leader>l", "c[]()<Esc>F]Pf(a", {
  buffer = true,
  desc = "Create markdown link from selection",
})
