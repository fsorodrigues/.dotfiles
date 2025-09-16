return {
	"L3MON4D3/LuaSnip",
	version = "v2.*",
	build = "make install_jsregexp",
	config = function()
		local ls = require("luasnip")
		local types = require("luasnip.util.types")
		ls.config.set_config({
			history = true,
			update_events = "TextChanged,TextChangedI",
			region_check_events = "InsertEnter",
			delete_check_events = "TextChanged,InsertLeave",
			ext_opts = {
				[types.choiceNode] = {
					active = { virt_text = { { "⟵", "Error" } } },
				},
			},
		})

		require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/lua/snippets/" })
		local keymap = vim.keymap

		keymap.set({ "i", "s" }, "<C-j>", function()
			ls.jump(1)
		end, { silent = true })
		keymap.set({ "i", "s" }, "<C-k>", function()
			ls.jump(-1)
		end, { silent = true })
		keymap.set({ "i", "s" }, "<C-h>", function()
			if ls.choice_active() then
				ls.change_choice(1)
			end
		end, { silent = true })
	end,
}
