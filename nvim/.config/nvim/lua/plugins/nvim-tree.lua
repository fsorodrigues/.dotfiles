-- set keymaps
local keymap = vim.keymap -- for conciseness

-- custom keymaps
local function my_on_attach(bufnr)
  -- load api for functionalities
  local api = require("nvim-tree.api")

  -- declare opts
  local function opts(desc)
    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  local function opts_no_buff(desc)
    return { desc = "nvim-tree: " .. desc, noremap = true, silent = true, nowait = true }
  end
  -- set default keymappings
  api.config.mappings.default_on_attach(bufnr)

  -- remove default mapping
  keymap.del("n", "<C-k>", { buffer = bufnr })
  -- add new mappings
  keymap.set("n", "<leader>ee", "<cmd>NvimTreeToggle<CR>", opts_no_buff("Toggle file explorer")) -- toggle file explorer
  keymap.set("n", "<leader>ef", "<cmd>NvimTreeFindFileToggle<CR>", opts_no_buff("Toggle file explorer on current file")) -- toggle file explorer on current file
  keymap.set("n", "<leader>ec", "<cmd>NvimTreeCollapse<CR>", opts_no_buff("Collapse file explorer")) -- collapse file explorer
  keymap.set("n", "<leader>er", "<cmd>NvimTreeRefresh<CR>", opts("Refresh file explorer")) -- refresh file explorer
  keymap.set("n", "<leader>k", api.node.show_info_popup, opts("Show file info")) -- show info popup for current file/dir
  keymap.set("n", "a", api.fs.create, opts("Create")) -- create file/dir
end

return {
  "nvim-tree/nvim-tree.lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local nvimtree = require("nvim-tree")
    -- recommended settings from nvim-tree documentation
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    -- change color for arrows in tree to light blue
    vim.cmd([[ highlight NvimTreeFolderArrowClosed guifg=#3FC5FF ]])
    vim.cmd([[ highlight NvimTreeFolderArrowOpen guifg=#3FC5FF ]])
    vim.cmd([[ highlight NvimTreeIndentMarker guifg=#3FC5FF ]])
    -- configure nvim-tree
    nvimtree.setup({
      view = {
        width = 35,
      },
      -- change folder arrow icons
      renderer = {
        indent_markers = {
          enable = true,
        },
        icons = {
          glyphs = {
            folder = {
              arrow_closed = "", -- arrow when folder is closed
              arrow_open = "", -- arrow when folder is open
            },
          },
        },
        root_folder_label = function(path)
          return string.match(path, ".*(/.+)$") .. "/"
        end,
      },
      notify = {
        threshold = vim.log.levels.WARN,
      },
      diagnostics = {
        enable = true,
        show_on_dirs = true,
        icons = {
          hint = "",
          info = "",
          warning = "",
          error = "",
        },
      },
      -- disable window_picker for
      -- explorer to work well with
      -- window splits
      actions = {
        open_file = {
          window_picker = {
            enable = false,
          },
        },
      },
      filters = {
        custom = { ".DS_Store" },
      },
      git = {
        ignore = false,
      },
      on_attach = my_on_attach,
    })
  end,
}
