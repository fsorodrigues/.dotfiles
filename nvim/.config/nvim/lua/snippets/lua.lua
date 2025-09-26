local s = require("luasnip.nodes.snippet").S
local t = require("luasnip.nodes.textNode").T
local i = require("luasnip.nodes.insertNode").I
local c = require("luasnip.nodes.choiceNode").C
local fmta = require("luasnip.extras.fmt").fmta

return {
  -- keymap
  s(
    {
      trig = "km",
      desc = "Lua shorthand to scaffold a keymap. Comes with choices for `vim.keymap` or `keymap`, and different modes",
    },
    fmta([[<prop>.set(<mode>, <keys>, <cmd>, { desc = '<desc>' })]], {
      prop = c(1, { t("vim.keymap"), t("keymap") }),
      mode = c(2, { t('"n"'), t('{"n", "v"}') }),
      keys = i(3, ""),
      cmd = i(4, ""),
      desc = i(0, "keymap description"),
    })
  ),
  -- function
  s(
    {
      trig = "fn",
      desc = "Lua shorthand to scaffold a function",
    },
    fmta(
      [[ 
      function(<args>)
        <action>
      end
    ]],
      {
        args = i(1, ""),
        action = i(0, ""),
      }
    )
  ),
}
