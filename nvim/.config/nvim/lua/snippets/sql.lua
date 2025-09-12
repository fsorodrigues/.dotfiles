local s = require("luasnip.nodes.snippet").S
local t = require("luasnip.nodes.textNode").T
local i = require("luasnip.nodes.insertNode").I

return {
  s("ref", {
    t("{{ ref("),
    i(1, "t", { key = "i1" }),
    t(") }}"),
  })
}

