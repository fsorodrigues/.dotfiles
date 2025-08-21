return {
  "mason-org/mason.nvim",
  opts = {
    ui = {
      icons = {
        package_installed = "✓",
        package_pending = "➜",
        package_uninstalled = "✗",
      },
    },
  },
  config = function(_, opts)
    vim.keymap.set("n", "<leader>mas", "<CMD>Mason<CR>", { desc = "Open Mason" })
    require("mason").setup(opts)
  end
}
