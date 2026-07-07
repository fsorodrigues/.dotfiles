return {
  "chrisgrieser/nvim-origami",
  event = "VeryLazy",
  opts = {
    autoFold = { enabled = false },
    foldKeymaps = { setup = false, hOnlyOpensOnFirstColumn = false },
  },
  -- recommended: disable vim's auto-folding
  init = function()
    vim.opt.foldlevel = 99
    vim.opt.foldlevelstart = 99
    local origami = require("origami")

    -- fold
    vim.keymap.set("n", "<leader>hh", function()
      vim.cmd.normal("^")
      origami.h()
    end, { desc = "Origami keymap to fold" })
    -- unfold
    vim.keymap.set("n", "<leader>ll", function()
      origami.l()
    end, { desc = "Origami keymap to unfold" })
    -- unfold recursively
    vim.keymap.set("n", "<leader>$", function()
      origami.dollar()
    end, { desc = "Origami keymap to unfold recursively" })
  end,
}
