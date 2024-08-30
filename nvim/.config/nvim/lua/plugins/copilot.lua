return {
  "github/copilot.vim",
  config = function()
    vim.g.copilot_enabled = false
    vim.keymap.set("i", "<C-c>", "<Plug>(copilot-suggest)", { noremap = false })
  end,
}
