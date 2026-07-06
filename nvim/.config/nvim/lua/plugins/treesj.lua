return {
  "Wansmer/treesj",
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  config = function()
    local treesj = require("treesj")
    treesj.setup({ use_default_keymaps = false })

    vim.keymap.set("n", "<leader>st", function()
      treesj.toggle()
    end, { desc = "Toggle node single/multiline" })
    vim.keymap.set("n", "<leader>sj", function()
      treesj.join()
    end, { desc = "Join node from multiline to single line" })
    vim.keymap.set("n", "<leader>ss", function()
      treesj.split()
    end, { desc = "Split node from single to multiline" })
  end,
}
