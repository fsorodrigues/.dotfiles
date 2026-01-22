return {
	"mfussenegger/nvim-lint",
	event = { "BufReadPost", "BufNewFile" },
	dependencies = {
		"williamboman/mason.nvim",
	},
	config = function()
		local lint = require("lint")
		-- lint.linters.sqlfluff.args = {
		-- 	"lint",
		-- 	"--format=json",
		-- 	"--config=.sqlfluff",
		-- }
		--
		-- lint.linters_by_ft = {
		-- 	sql = { "sqlfluff" },
		-- }
		--
		-- vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost" }, {
		-- 	group = vim.api.nvim_create_augroup("nvim-lint-autocmds", { clear = true }),
		-- 	callback = function()
		-- 		lint.try_lint()
		-- 	end,
		-- })
	end,
}
