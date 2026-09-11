return {
  "nvim-treesitter/nvim-treesitter-textobjects",
  branch = "main",
  lazy = false,
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
  },
  config = function()
    require("nvim-treesitter-textobjects").setup({
      select = {
        lookahead = true,
        include_surrounding_whitespace = true,
      },
    })

    local select = require("nvim-treesitter-textobjects.select")
    local selections = {
      ["a="] = {
        "@assignment.outer",
        "Select outer part of an assignment region",
      },
      ["i="] = {
        "@assignment.inner",
        "Select inner part of an assignment region",
      },
      ["a:"] = {
        "@parameter.outer",
        "Select outer part of a parameter/field region",
      },
      ["i:"] = {
        "@parameter.inner",
        "Select inner part of a parameter/field region",
      },
      ["ai"] = {
        "@conditional.outer",
        "Select outer part of a conditional region",
      },
      ["ii"] = {
        "@conditional.inner",
        "Select inner part of a conditional region",
      },
      ["al"] = { "@loop.outer", "Select outer part of a loop region" },
      ["il"] = { "@loop.inner", "Select inner part of a loop region" },
      ["ab"] = { "@block.outer", "Select outer part of a block region" },
      ["ib"] = { "@block.inner", "Select inner part of a block region" },
      ["af"] = { "@function.outer", "Select outer part of a function region" },
      ["if"] = { "@function.inner", "Select inner part of a function region" },
      ["ac"] = { "@class.outer", "Select outer part of a class region" },
      ["ic"] = { "@class.inner", "Select inner part of a class region" },
    }

    for key, mapping in pairs(selections) do
      vim.keymap.set({ "x", "o" }, key, function()
        select.select_textobject(mapping[1], "textobjects")
      end, { desc = mapping[2] })
    end

    local swap = require("nvim-treesitter-textobjects.swap")
    vim.keymap.set("n", "<leader>on", function()
      swap.swap_next("@parameter.inner")
    end, { desc = "Swap with next parameter" })
    vim.keymap.set("n", "<leader>op", function()
      swap.swap_previous("@parameter.inner")
    end, { desc = "Swap with previous parameter" })
  end,
}
