return {
  "NStefan002/screenkey.nvim",
  branch = "main",
  keys = { "<leader>sk" },
  config = function()
    vim.keymap.set("n", "<leader>sk", function()
      require("screenkey").toggle()
    end, { desc = "Toggle Screen Key on/off" })
  end,
}
