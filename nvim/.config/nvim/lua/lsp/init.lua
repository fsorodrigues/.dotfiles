-- LUA
vim.lsp.config("lua_ls", {
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT",
      },
      diagnostics = {
        globals = { "vim" },
      },
    },
  },
})

-- GO
vim.lsp.config("gopls", {
  settings = {
    gopls = {
      completeUnimported = true,
      usePlaceholders = true,
      analyses = {
        unusedparams = true,
      },
    },
  },

  on_attach = function(_, bufnr)
    -- Enable organizing imports on save
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = vim.api.nvim_create_augroup("GoFormat", { clear = true }),
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.code_action({
          apply = true,
          context = {
            only = { "source.organizeImports" },
            diagnostics = {},
          },
          bufnr = bufnr,
        })
      end,
    })
  end,
})

local enabled_servers = {
  "lua_ls",
  "gopls",
  "yamlls",
  "ty",
}

local dbt_ls_root = vim.env.DBT_LS_ROOT
local dbt_ls_bin = dbt_ls_root and (dbt_ls_root .. "/bin/dbt-ls")

if dbt_ls_bin and vim.fn.executable(dbt_ls_bin) == 1 then
  vim.lsp.config("dbt-ls", {
    cmd = {
      dbt_ls_bin,
      "--log-level",
      "trace",
    },
    filetypes = { "sql" },
    root_markers = { "dbt_project.yml", "dbt_project.yaml" },
    workspace_required = true,
  })

  table.insert(enabled_servers, "dbt-ls")
end

vim.lsp.enable(enabled_servers)
