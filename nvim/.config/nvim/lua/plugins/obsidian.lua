return {
  "epwalsh/obsidian.nvim",
  version = "*",
  lazy = true,
  ft = "markdown",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  opts = {
    workspaces = {
      {
        name = "fsorodrigues",
        path = "~/.obsidian-vaults/fsorodrigues",
      },
    },
    ui = {
      enable = false,
    }, -- disable the UI to use the plugin only for the workspace functionality
  },
}
