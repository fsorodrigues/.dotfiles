return {
  {
    "github/copilot.vim",
    config = function()
      vim.g.copilot_enabled = false
      vim.keymap.set(
        "i",
        "<C-c>",
        "<Plug>(copilot-suggest)",
        { noremap = false }
      )
      vim.keymap.set(
        "i",
        "<C-x>",
        "<Plug>(copilot-suggest-line)",
        { noremap = false }
      )
    end,
  },
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = {
      { "github/copilot.vim" }, -- or zbirenbaum/copilot.lua
      { "nvim-lua/plenary.nvim", branch = "master" }, -- for curl, log and async functions
    },
    build = "make tiktoken", -- Only on MacOS or Linux
    config = function()
      require("CopilotChat").setup({
        model = "gemini-3-pro-preview",
        providers = {
          github_models = { disabled = true },
          copilot_embeddings = { disabled = true },
        },
        mappings = {
          reset = {
            normal = "<C-r>",
            insert = "<C-r>",
          },
        },
      })

      -- keymaps
      vim.keymap.set(
        "n",
        "<leader>cc",
        "<cmd>CopilotChatOpen<CR>",
        { noremap = false }
      )
      vim.keymap.set(
        "n",
        "<leader>cp",
        "<cmd>CopilotChatPrompt<CR>",
        { noremap = false }
      )
    end,
  },
}
