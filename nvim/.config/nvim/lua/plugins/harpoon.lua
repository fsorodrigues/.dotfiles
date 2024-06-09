return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  config = function()
    local harpoon = require("harpoon")
    local keymap = vim.keymap -- for conciseness
    harpoon:setup()

    -- basic telescope configuration
    local conf = require("telescope.config").values
    local function toggle_telescope(harpoon_files)
      local file_paths = {}
      for _, item in ipairs(harpoon_files.items) do
        table.insert(file_paths, item.value)
      end

      local make_finder = function()
        local paths = {}
        for _, item in ipairs(harpoon_files.items) do
          table.insert(paths, item.value)
        end

        return require("telescope.finders").new_table({
          results = paths,
        })
      end

      require("telescope.pickers")
        .new({}, {
          prompt_title = "Harpoon",
          finder = require("telescope.finders").new_table({
            results = file_paths,
          }),
          previewer = conf.file_previewer({}),
          sorter = conf.generic_sorter({}),
          attach_mappings = function(prompt_buffer_number, map)
            map(
              "i",
              "dd", -- your mapping here
              function()
                local state = require("telescope.actions.state")
                local selected_entry = state.get_selected_entry()
                local current_picker = state.get_current_picker(prompt_buffer_number)

                harpoon:list():removeAt(selected_entry.index)
                current_picker:refresh(make_finder())
              end
            )

            return true
          end,
        })
        :find()
    end

    -- kudos to @skykosiner for this PR
    local function getCurrentBufIdx(list)
      local current_file = vim.api.nvim_buf_get_name(0):gsub(vim.fn.getcwd() .. "/", "")
      for idx, item in ipairs(list.items) do
        if item.value == current_file then
          return idx
        end
      end

      return nil
    end
    -- set telescope toggle keymap
    keymap.set("n", "<leader>hl", function()
      toggle_telescope(harpoon:list())
    end, { desc = "Open harpoon window" })

    -- set other keymaps
    keymap.set("n", "<leader>hm", function()
      harpoon:list():append()
    end, { desc = "Mark file with harpoon" })

    keymap.set("n", "<leader>hu", function()
      harpoon:list():remove()
    end, { desc = "Unmark file with harpoon" })

    keymap.set("n", "<leader>hn", function()
      local list = harpoon:list()
      list:next({ ui_nav_wrap = true })
    end, { desc = "Go to next harpoon mark" })

    keymap.set("n", "<leader>hg", function()
      local list = harpoon:list()
      list:prev({ ui_nav_wrap = true })
    end, { desc = "Go to previous harpoon mark" })

    -- Set <space>1..<space>5 be my shortcuts to moving to the files
    for _, idx in ipairs({ 1, 2, 3, 4, 5 }) do
      vim.keymap.set("n", string.format("<leader>%d", idx), function()
        harpoon:list():select(idx)
      end)
    end
  end,
}
