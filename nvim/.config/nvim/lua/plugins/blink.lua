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
    sources = {
      default = { "lsp", "path", "snippets", "buffer" },
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
          winhighlight = 'Normal:BlinkCmpDoc,FloatBorder:BlinkCmpDocBorder,EndOfBuffer:BlinkCmpDoc',
        },
        auto_show = true,
        auto_show_delay_ms = 500,
      },
    },
    keymap = {
      ['<Up>'] = false,
      ['<Down>'] = false,
      ['<C-k>'] = { 'select_prev', 'fallback' },
      ['<C-j>'] = { 'select_next', 'fallback' },
      ['<C-y'] = false,
      ['<CR>'] = { 'select_and_accept', 'fallback' }
    }
  },
}
