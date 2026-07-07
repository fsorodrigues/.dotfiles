local script = vim.fn.expand("~/projects/tableau_user_utility/convert_to_csv.zsh")

vim.api.nvim_create_user_command("MakeTableauUser", function(args)
  if vim.fn.executable(script) ~= 1 then
    vim.notify("Tableau user utility not found: " .. script, vim.log.levels.WARN)
    return
  end

  vim.cmd(args.line1 .. "," .. args.line2 .. "!" .. vim.fn.fnameescape(script))
end, { range = true })
