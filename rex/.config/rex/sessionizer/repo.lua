local M = {}

function M.is_git_repo(dir_path)
  local result, err = rex.exec({
    "git",
    "-C",
    dir_path or ".",
    "rev-parse",
    "--is-inside-work-tree",
  })

  if result == nil then
    rex.log("warn", "could not check Git repository: " .. tostring(err))
    return false
  end

  return result.stdout:gsub("%s+", "") == "true"
end

return M
