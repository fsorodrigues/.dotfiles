local s = require("luasnip.nodes.snippet").S
local t = require("luasnip.nodes.textNode").T
local i = require("luasnip.nodes.insertNode").I
local c = require("luasnip.nodes.choiceNode").C
local fmta = require("luasnip.extras.fmt").fmta

return {
  --[[------------------------------
      DBT YAML SNIPPETS
  --------------------------------]]
  -- column
  s(
    {
      trig = "col",
      desc = "dbt yaml config shorthand for adding a column with name and description",
    },
    fmta(
      [[
      - name: <col_name>
        description: >>
          <desc>
    ]],
      {
        col_name = c(
          1,
          { i(1, "col_name"), { t("'\""), i(1, "col_name"), t("\"'") } }
        ),
        desc = i(0, "Column description."),
      }
    )
  ),
}
