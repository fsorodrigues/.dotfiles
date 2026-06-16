vim.api.nvim_create_user_command("MakeTableauUser", function()
  vim.cmd("'<,'>!~/projects/tableau_user_utility/convert_to_csv.zsh")
end, { range = true })
