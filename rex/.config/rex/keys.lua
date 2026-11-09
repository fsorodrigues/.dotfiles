require("utils")

-- reload
rex.bind(UseLeader(LEADER, "r"), "client.config.reload")

-- tab
rex.bind("ctrl+b", "client.tab.new")
for i = 1, 5 do
  rex.bind("option+" .. i, "client.tab.goto", { index = i })
end
rex.bind(UseLeader(LEADER, "x"), "client.tab.close")

-- panes
rex.bind(UseLeader(LEADER, "v"), "pane.split", { direction = "right" })
rex.bind(UseLeader(LEADER, "h"), "pane.split", { direction = "down" })
rex.bind(UseLeader(LEADER, "x"), "pane.close")

-- pane focus
rex.bind("ctrl+h", "pane.focus.left")
rex.bind("ctrl+j", "pane.focus.down")
rex.bind("ctrl+k", "pane.focus.up")
rex.bind("ctrl+l", "pane.focus.right")

-- pane size
rex.bind("option+h", "pane.resize", { direction = "left", amount = 5 })
rex.bind("option+j", "pane.resize", { direction = "down", amount = 5 })
rex.bind("option+k", "pane.resize", { direction = "up", amount = 5 })
rex.bind("option+l", "pane.resize", { direction = "right", amount = 5 })

-- this snippet from https://github.com/baggiponte/rex-navigator.nvim,
-- which requires a companion plugin in nvim
local data = os.getenv("XDG_DATA_HOME")
  or (os.getenv("HOME") .. "/.local/share")
local plugin = data .. "/nvim/lazy/rex-navigator.nvim"
local ok, err = pcall(function()
  dofile(plugin .. "/rex/navigator.lua").setup()
end)
if not ok then
  rex.log("warn", "rex-navigator not loaded: " .. tostring(err))
end
