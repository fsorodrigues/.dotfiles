return {
  "stevearc/conform.nvim",
  opts = function()
    return {
      formatters_by_ft = {
        sql = { "sqlfluff" },
        lua = { "stylua", lsp_format = "fallback" },
        go = { "gofumpt", "goimports", "golines", lsp_format = "fallback" },
      },
      formatters = {
        sqlfluff = {
          -- command = "sqlfluff",
          -- args = { "fix", "--force", "--quiet", "$FILENAME" },
          -- stdin = false,
          cwd = require("conform.util").root_file({
            ".sqlfluff",
            "pyproject.toml",
            "setup.cfg",
          }),
        },
      },
      format_on_save = {
        timeout_ms = 10000,
      },
      default_format_opts = { async = true },
    }
  end,
}

