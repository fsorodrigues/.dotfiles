local windows = require("windows")
local repo = require("repo")

local selected = rex.args.selected
if selected == nil or selected == "" then
  return
end

local initial_windows = {
  windows.zsh(selected),
}

if repo.is_git_worktree(selected) then
  table.insert(initial_windows, windows.lazygit(selected))
end

local session, err = rex.call("session.create", {
  label = selected:match("([^/]+)$") or selected,
  initial_windows = initial_windows,
})

if session == nil then
  error(err, 0)
end

rex.client.queue("session.select", { session_id = session.session_id })
return session
