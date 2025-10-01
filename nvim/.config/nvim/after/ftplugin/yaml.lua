local get_first_occurence = function(line_content, pat)
  -- Find the first non-whitespace character
  local first_char_col = 0
  for i = 1, #line_content do
    if not string.match(line_content:sub(i, i), pat) then
      first_char_col = i - 1 -- Adjust for 0-based indexing in Neovim API
      break
    end
  end

  return first_char_col
end

vim.api.nvim_create_user_command("SortYamlArray", function(args)
  local key = args.fargs[1] == nil and ".columns" or "." .. args.fargs[1]
  local new_key = args.fargs[1] == nil and "columns" or args.fargs[1]
  local id = args.fargs[2] == nil and ".name" or "." .. args.fargs[2]

  local line1 = args.line1
  local line = vim.api.nvim_buf_get_lines(0, line1 - 1, line1, false)[1]
  local indentation_column = get_first_occurence(line, "%s")
  local sw = vim.opt.shiftwidth:get()
  local required_indents = indentation_column / sw

  local cmd = "'<,'>!yq -Y '"
    .. key
    .. " | sort_by("
    .. id
    .. ") | { "
    .. new_key
    .. ": . }'"
  vim.cmd(cmd)

  local indent_cmd = "norm `[v`]" .. required_indents .. ">"
  vim.cmd(indent_cmd)
end, {
  nargs = "*",
  range = true,
  desc = "A custom user command to reorder some yaml. Mostly for dbt column entries, but attempted to be made general",
})
