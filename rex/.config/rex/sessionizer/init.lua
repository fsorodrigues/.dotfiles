local DEFAULT_SEARCH_DEPTH = 1

---@class SearchPath
---@field path string
---@field depth integer

---@type SearchPath[]
local DEFAULT_SEARCH_PATHS = {
  { path = "~", depth = DEFAULT_SEARCH_DEPTH },
  { path = "~/Documents", depth = DEFAULT_SEARCH_DEPTH },
}

local windows = require("sessionizer.windows")

local config_dir = os.getenv("XDG_CONFIG_HOME")
  or (os.getenv("HOME") .. "/.config")
local picker_script = config_dir .. "/rex/sessionizer/pick.lua"

local function search_path_key(path)
  if path == "/" then
    return path
  end

  return path:gsub("/+$", "")
end

local function merge_search_paths(defaults, overrides)
  local merged = {}
  local positions = {}

  local function upsert(search_path)
    if type(search_path) ~= "table" or type(search_path.path) ~= "string" then
      return
    end

    local key = search_path_key(search_path.path)
    local position = positions[key]

    if position == nil then
      positions[key] = #merged + 1
      merged[#merged + 1] = search_path
    else
      merged[position] = search_path
    end
  end

  for _, search_path in ipairs(defaults) do
    upsert(search_path)
  end

  for _, search_path in ipairs(overrides) do
    upsert(search_path)
  end

  return merged
end

local local_search_paths = {}
local local_config = config_dir .. "/rex/sessionizer/local.lua"
local loader = loadfile(local_config)

if loader ~= nil then
  local ok, result = pcall(loader)
  if ok and type(result) == "table" then
    local_search_paths = result
  end
end

local SEARCH_PATHS = merge_search_paths(DEFAULT_SEARCH_PATHS, local_search_paths)

local picker_shell = [[
session_id=$1
picker_script=$2
shift 2

selected="$({
  while [ "$#" -gt 0 ]; do
    raw_path=$1
    depth=$2
    shift 2

    if [ "$raw_path" = "~" ]; then
      path="$HOME"
    elif [ "${raw_path%%/*}" = "~" ]; then
      path="$HOME/${raw_path#??}"
    else
      path="$raw_path"
    fi

    if [ -d "$path" ]; then
      fd \
        --follow \
        --type d \
        --hidden \
        --no-ignore \
        --absolute-path \
        --min-depth 1 \
        --max-depth "$depth" \
        --exclude .git \
        --exclude .jj \
        . "$path"
    fi
  done
} 2>/dev/null | sed 's:/$::' | sort -u | fzf --height=100% --reverse)"

if [ -n "$selected" ]; then
  rex do -s "$session_id" "$picker_script" "selected=$selected"
fi
]]

rex.action({
  name = "sessionizer_session_create",
  title = "Select a directory for a new session",
  run = function(ctx)
    if ctx.session_id == nil then
      error("sessionizer must run inside a session", 0)
    end

    -- `/bin/sh -c` uses the first values as `$1` (session) and `$2` (script).
    -- The remaining arguments are consumed as path/depth pairs by picker_shell.
    -- They are added to the tail of the command in the for loop below:
    -- the command ends up something like this:
    -- /bin/sh -c ... ./pick.lua <path 1> <depth 1> <path 2> <depth 2> ...
    local picker_command = {
      "/bin/sh",
      "-c",
      picker_shell,
      "rex-sessionizer-picker",
      ctx.session_id,
      picker_script,
    }

    for _, search_path in ipairs(SEARCH_PATHS) do
      table.insert(picker_command, search_path.path)
      table.insert(picker_command, tostring(search_path.depth))
    end

    local _, err = rex.session.new_layer(windows.picker(picker_command))

    if err ~= nil then
      error(err, 0)
    end
  end,
})

rex.bind("ctrl+g", "sessionizer_session_create")
