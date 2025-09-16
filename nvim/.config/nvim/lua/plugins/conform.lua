return {
	"stevearc/conform.nvim",
	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
			sql = { "sqlfluff" },
			go = { "gofumpt", lsp_format = "fallback" },
		},
		format_on_save = {
			timeout_ms = 5000,
		},
		default_format_opts = { async = true },
	},
}
