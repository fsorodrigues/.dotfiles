---Generates a leader-prefixed string
---@param LEADER string The leader key in string format
---@param key string The key to be used after the leader
---@return string The prefixed key in Rex's leader format for keybinding
function UseLeader(LEADER, key)
  return LEADER .. ">" .. key
end
