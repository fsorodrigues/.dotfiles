-- LUA
vim.lsp.config("lua_ls", {
	settings = {
		Lua = {
			runtime = {
				version = "LuaJIT",
			},
			diagnostics = {
				globals = { "vim" },
			},
		},
	},
})

-- GO
vim.lsp.config("gopls", {
	settings = {
		gopls = {
			completeUnimported = true,
			usePlaceholders = true,
			analyses = {
				unusedparams = true,
			},
		},
	},
	on_attach = function(_, bufnr)
		-- Enable organizing imports on save
		vim.api.nvim_create_autocmd("BufWritePre", {
			group = vim.api.nvim_create_augroup("GoFormat", { clear = true }),
			buffer = bufnr,
			callback = function()
				vim.lsp.buf.code_action({
					apply = true,
					context = {
						only = { "source.organizeImports" },
						diagnostics = {},
					},
					bufnr = bufnr,
				})
			end,
		})
	end,
})

vim.lsp.config("dbt_ls", {
	cmd = {
		"/Users/fsorodrigues/Documents/projects/dbt-ls/bin/dbt-ls",
		"--log-file",
		"/Users/fsorodrigues/Documents/projects/dbt-ls/log/log.txt",
		"--log-level",
		"debug", -- "info" for less verbose (but please use debug to help catch bugs and improve this)
	},
	filetypes = { "sql" },
	root_markers = { "dbt_project.yml", "dbt_project.yaml", ".git" },
})

vim.lsp.enable({
	"lua_ls",
	"gopls",
	"svelte",
	"tailwindcss",
	"ty",
	"dbt_ls",
})
