return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPost", "BufNewFile" },
  dependencies = {
    "williamboman/mason.nvim",
  },
  config = function()
    local lint = require("lint")
    local function sqlfluff_cwd(bufnr)
      local file = vim.api.nvim_buf_get_name(bufnr)

      if file == "" then
        return vim.fn.getcwd()
      end

      local start_dir = vim.fs.dirname(file)

      if not start_dir then
        return vim.fn.getcwd()
      end
      local config = vim.fs.find({
        ".sqlfluff",
      }, {
        path = start_dir,
        upward = true,
      })[1]

      if config then
        return vim.fs.dirname(config)
      end
      return start_dir
    end

    lint.linters_by_ft = {
      sql = { "sqlfluff" },
      go = { "golangcilint" },
    }

    local sqlfluff_default = lint.linters.sqlfluff
    lint.linters.sqlfluff = {
      cmd = sqlfluff_default.cmd,
      args = { "lint", "--format=json" },
      ignore_exitcode = sqlfluff_default.ignore_exitcode,
      stdin = sqlfluff_default.stdin,
      parser = sqlfluff_default.parser,
    }

    vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost" }, {
      pattern = "*",
      group = vim.api.nvim_create_augroup(
        "nvim-lint-autocmds",
        { clear = true }
      ),
      callback = function(args)
        lint.try_lint(nil, {
          cwd = sqlfluff_cwd(args.buf),
        })
      end,
    })
  end,
}
