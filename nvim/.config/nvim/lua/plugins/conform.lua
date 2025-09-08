return {
  'stevearc/conform.nvim',
  opts = {
    formatters_by_ft = {
      sql = { "sqlfluff" },
    },
    format_on_save = {
      timeout_ms = 5000,
    },
    default_format_opts = { async = true }
  },
}
