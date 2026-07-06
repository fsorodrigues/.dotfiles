return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
    "mike-jl/harpoonEx",
  },
  config = function()
    local harpoon = require("harpoon")
    local keymap = vim.keymap -- for conciseness
    harpoon:setup()

    local harpoonEx = require("harpoonEx")
    -- load extension
    harpoon:extend(harpoonEx.extend())

    -- set Telescope integration
    vim.keymap.set("n", "<leader>hl", function()
      require("telescope").extensions.harpoonEx.harpoonEx({
        -- Optional: modify mappings, default mappings:
        attach_mappings = function(_, map)
          local actions = require("telescope").extensions.harpoonEx.actions
          map({ "i", "n" }, "<C-d>", actions.delete_mark)
          map({ "i", "n" }, "<M-k>", actions.move_mark_up)
          map({ "i", "n" }, "<M-j>", actions.move_mark_down)
          return true
        end,
      })
      return true
    end, { desc = "Open harpoon window" })

    -- set other keymaps
    keymap.set("n", "<leader>hh", function()
      harpoon:list():add()
    end, { desc = "Mark file with harpoon" })

    keymap.set("n", "<leader>hg", function()
      harpoon:list():remove()
    end, { desc = "Unmark file with harpoon" })

    -- go to file by index
    keymap.set("n", "<leader>1", function()
      harpoon:list():select(1)
    end, { desc = "Go to file 1 in harpoon list" })
    keymap.set("n", "<leader>2", function()
      harpoon:list():select(2)
    end, { desc = "Go to file 2 in harpoon list" })
    keymap.set("n", "<leader>3", function()
      harpoon:list():select(3)
    end, { desc = "Go to file 3 in harpoon list" })
    keymap.set("n", "<leader>4", function()
      harpoon:list():select(4)
    end, { desc = "Go to file 4 in harpoon list" })
    keymap.set("n", "<leader>5", function()
      harpoon:list():select(5)
    end, { desc = "Go to file 5 in harpoon list" })

    -- cycle through files in order
    local opts = { ui_nav_wrap = true }
    keymap.set("n", "<leader>hn", function()
      harpoon:list():next(opts)
    end, { desc = "Go to next harpoon mark" })
    keymap.set("n", "<leader>hy", function()
      harpoon:list():prev(opts)
    end, { desc = "Go to previous harpoon mark" })
  end,
}
