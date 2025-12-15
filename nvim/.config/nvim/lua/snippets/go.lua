local s = require("luasnip.nodes.snippet").S
local f = require("luasnip.nodes.functionNode").F
local t = require("luasnip.nodes.textNode").T
local i = require("luasnip.nodes.insertNode").I

-- Adapted from https://github.com/tjdevries/config_manager/blob/1a93f03dfe254b5332b176ae8ec926e69a5d9805/xdg_config/nvim/lua/tj/snips/ft/go.lua
local function same(index)
  return f(function(args)
    return args[1]
  end, { index })
end

return {
  s("smarterr", {
    i(1, "_"),
    t(", "),
    i(2, "err"),
    t(" := "),
    i(3),
    t({ "", "if " }),
    same(2),
    t({ " != nil {", "" }),
    i(0),
    t({ "", "}" }),
  }),
  s("iferr", {
    t({ "if " }),
    i(1, "err"),
    t({ " != nil {", "" }),
    i(0),
    t({ "", "}" }),
  }),
}
