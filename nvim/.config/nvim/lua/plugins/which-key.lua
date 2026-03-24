return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    preset = "helix",
    triggers = {},
    delay = 500,
  },
  keys = {
    {
      "??",
      function()
        require("which-key").show()
      end,
      desc = "Show keymaps with which-key",
    },
  },
}
