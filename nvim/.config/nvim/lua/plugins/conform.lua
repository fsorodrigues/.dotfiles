return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      sql = { "sqlfluff" },
      lua = { "stylua", lsp_format = "fallback" },
      go = { "gofumpt", lsp_format = "fallback" },
    },
    format_on_save = {
      timeout_ms = 10000,
    },
    default_format_opts = { async = true },
  },
}
