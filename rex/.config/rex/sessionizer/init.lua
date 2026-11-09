local windows = require("sessionizer.windows")

local config_dir = os.getenv("XDG_CONFIG_HOME")
  or (os.getenv("HOME") .. "/.config")
local picker_script = config_dir .. "/rex/sessionizer/pick.lua"

local picker_shell = [[
selected="$({
  for root in "$HOME/Downloads" "$HOME/Documents"; do
    if [ -d "$root" ]; then
      printf '%s\n' "$root"
      fd --type d --absolute-path . "$root"
    fi
  done
} 2>/dev/null | sed 's:/$::' | sort -u | fzf --height=100% --reverse)"

if [ -n "$selected" ]; then
  rex do -s "$1" "$2" "selected=$selected"
fi
]]

rex.action({
  name = "sessionizer_session_create",
  title = "Select a directory for a new session",
  run = function(ctx)
    if ctx.session_id == nil then
      error("sessionizer must run inside a session", 0)
    end

    local _, err = rex.session.new_layer(windows.picker({
      "/bin/sh",
      "-c",
      picker_shell,
      "rex-sessionizer-picker",
      ctx.session_id,
      picker_script,
    }))

    if err ~= nil then
      error(err, 0)
    end
  end,
})

rex.bind("ctrl+/", "sessionizer_session_create")
