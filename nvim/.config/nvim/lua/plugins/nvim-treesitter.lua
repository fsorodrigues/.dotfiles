return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = ":TSUpdate",
    dependencies = {
      "windwp/nvim-ts-autotag",
    },
    config = function()
      -- These are parser names, which can differ from Neovim filetypes.
      require("nvim-treesitter").install({
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
        "sql",
      })

      vim.api.nvim_create_autocmd("FileType", {
        -- These are filetypes, not parser names: tsx -> typescriptreact and
        -- bash -> sh. markdown_inline is injection-only, so it has no entry.
        -- Neovim 0.12's Lua and Markdown ftplugins already start Tree-sitter.
        pattern = {
          "json",
          "javascript",
          "javascriptreact",
          "typescript",
          "typescriptreact",
          "yaml",
          "html",
          "css",
          "scss",
          "svelte",
          "sh",
          "vim",
          "dockerfile",
          "gitignore",
          "python",
          "go",
          "sql",
        },
        callback = function()
          vim.treesitter.start()
          vim.bo.indentexpr =
            "v:lua.require'nvim-treesitter'.indentexpr()"
        end,
      })

      require("nvim-ts-autotag").setup()
    end,
  },
}
