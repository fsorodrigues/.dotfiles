return {
  {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPre", "BufNewFile" },
    build = ":TSUpdate",
    dependencies = {
      "windwp/nvim-ts-autotag",
    },
    config = function()
      -- import nvim-treesitter plugin
      local treesitter = require("nvim-treesitter.configs")

      -- configure treesitter
      treesitter.setup({ -- enable syntax highlighting
        highlight = {
          enable = true,
        },
        -- enable indentation
        indent = { enable = true },
        -- ensure these language parsers are installed
        ensure_installed = {
          "json",
          "javascript",
          "typescript",
          "tsx",
          "yaml",
          "html",
          "css",
          "scss",
          "markdown",
          "markdown_inline",
          "svelte",
          "bash",
          "lua",
          "vim",
          "dockerfile",
          "gitignore",
          "python",
          "go",
        },
        -- auto install above language parsers
        auto_install = true,
      })

      require("nvim-ts-autotag").setup()
    end,
  },
}
