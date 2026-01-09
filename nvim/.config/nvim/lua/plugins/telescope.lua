return {
  "nvim-telescope/telescope.nvim",
  tag = "v0.2.1",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    "nvim-tree/nvim-web-devicons",
    {
      "nvim-telescope/telescope-live-grep-args.nvim",
      version = "^1.1.0",
    },
    "nvim-telescope/telescope-ui-select.nvim",
  },
  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")
    local themes = require("telescope.themes")

    telescope.setup({
      defaults = {
        path_display = { "truncate " },
        mappings = {
          i = {
            ["<C-k>"] = actions.move_selection_previous, -- move to prev result
            ["<C-j>"] = actions.move_selection_next, -- move to next result
            ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
            ["<C-v>"] = false,
            ["<C-s>"] = actions.file_vsplit,
            ["<C-h>"] = actions.file_split,
          },
        },
        layout_config = {
          width = 0.95,
          height = 0.95,
          prompt_position = "top",
          preview_width = 0.4,
        },
        preview = {
          filesize_limit = 5,
        },
      },
      extensions = {
        ["ui-select"] = {
          themes.get_cursor(),
        },
      },
    })

    telescope.load_extension("fzf")
    telescope.load_extension("live_grep_args")
    telescope.load_extension("ui-select")

    -- set keymaps
    local keymap = vim.keymap -- for conciseness

    keymap.set(
      "n",
      "<leader>ff",
      "<cmd>Telescope find_files<cr>",
      { desc = "Fuzzy find files in cwd" }
    )
    keymap.set(
      "n",
      "<leader>fa",
      "<cmd>Telescope find_files hidden=true<cr>",
      { desc = "Fuzzy find files in cwd, including hidden files" }
    )
    keymap.set(
      "n",
      "<leader>fr",
      "<cmd>Telescope oldfiles<cr>",
      { desc = "Fuzzy find recent files" }
    )
    keymap.set("n", "<leader>fs", function()
      telescope.extensions.live_grep_args.live_grep_args()
    end, { desc = "Find string in cwd with ripgrep args" })
    keymap.set(
      "n",
      "<leader>fc",
      "<cmd>Telescope grep_string<cr>",
      { desc = "Find string under cursor in cwd" }
    )
  end,
}
