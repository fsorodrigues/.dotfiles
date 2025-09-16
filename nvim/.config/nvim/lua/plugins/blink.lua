return {
	"saghen/blink.cmp",
	dependencies = { "rafamadriz/friendly-snippets" },
	version = "1.*",
	opts = {
		signature = { enabled = true },
		appearance = {
			use_nvim_cmp_as_default = false,
			nerd_font_variant = "normal",
		},
		snippets = { preset = "luasnip" },
		sources = {
			default = { "lsp", "snippets", "path", "buffer" },
		},
		completion = {
			menu = {
				border = nil,
				scrolloff = 1,
				scrollbar = false,
				draw = {
					columns = {
						{ "kind_icon" },
						{ "label", "label_description", gap = 1 },
						{ "kind" },
						{ "source_name" },
					},
				},
			},
			documentation = {
				window = {
					border = nil,
					scrollbar = false,
					winhighlight = "Normal:BlinkCmpDoc,FloatBorder:BlinkCmpDocBorder,EndOfBuffer:BlinkCmpDoc",
				},
				auto_show = true,
				auto_show_delay_ms = 750,
			},
			trigger = { show_in_snippet = false },
		},
		keymap = {
			preset = "none",
			["<C-k>"] = { "select_prev", "fallback" },
			["<C-j>"] = { "select_next", "fallback" },
			["<C-c>"] = { "hide", "fallback" },
			["<C-l>"] = { "show_documentation", "hide_documentation" },
			["<CR>"] = { "select_and_accept", "fallback" },
		},
	},
}
